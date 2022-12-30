
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include "log_info.h"

#define YEAR_COMPENSATE (-85)

static const long log_file_max = 1024*1024*10;

#define DEBUG_MPRINTF_STATE 1

#if 1
// ubuntu
// \033 == \e == 0x1B

// 格式：\e[显示方式;前景色;背景色m输出字符串\e[0m

// 显示方式：
// 0默认；
// 1粗体；22非粗体
// 4单条下划线；24无下划线
// 5闪烁；25无闪烁
// 7反显（翻转前景背景色）；27无反显
// 8隐藏

// 颜色：30+前景色；40+背景色
// 0黑色；1红色；2黄色；4蓝色；5洋红色；6青色；7白色

// 部分控制：
#define CLEAR "\e[2j"			// 清屏
#define CLRLINE "\r\e[K"		// or "\e[K\r" 清除从光标到行尾的内容

#define RESET       "\033[0m"	// 恢复终端默认属性
#define BLACK       "\033[30m"             /* Black 黑色 */
#define RED         "\033[31m"             /* Red 红色 */
#define GREEN       "\033[32m"             /* Green 绿色 */
#define YELLOW      "\033[33m"             /* Yellow 黄的 */
#define BLUE        "\033[34m"             /* Blue 蓝色 */
#define MAGENTA     "\033[35m"             /* Magenta 品红 */
#define CYAN        "\033[36m"             /* Cyan 青色 */
#define WHITE       "\033[37m"             /* White 白色 */
#define BOLDBLACK   "\033[1;30m"      /* Bold Black 粗黑 */
#define BOLDRED     "\033[1;31m"      /* Bold Red 粗红 */
#define BOLDGREEN   "\033[1;32m"      /* Bold Green */
#define BOLDYELLOW  "\033[1;33m"      /* Bold Yellow */
#define BOLDBLUE    "\033[1;34m"      /* Bold Blue */
#define BOLDMAGENTA "\033[1;35m"      /* Bold Magenta */
#define BOLDCYAN    "\033[1;36m"      /* Bold Cyan */
#define BOLDWHITE   "\033[1;37m"      /* Bold White */
#endif

//struct timeval{
//	long int tv_sec; // 秒数
//	long int tv_usec; // 微秒数
//}
static char *__get_printfTime()
{
	static char cur_time[20];
#ifdef __linux__
	struct timeval tv;
	gettimeofday(&tv, NULL); // 获取1970-1-1到现在的时间结果保存到tv中
	uint64_t sec = tv.tv_sec;
	struct tm cur_tm; // 保存转换后的时间结果
	//tzset();
	localtime_r((time_t *)&sec, &cur_tm);
	snprintf(cur_time, 20, "%d-%02d-%02d %02d:%02d:%02d", cur_tm.tm_year + 1900, cur_tm.tm_mon + 1, cur_tm.tm_mday, cur_tm.tm_hour, cur_tm.tm_min, cur_tm.tm_sec);
#else
	time_t curtime = time(0);
	struct tm *tim = localtime(&curtime);
    snprintf(cur_time, 20, "%d-%02d-%02d %02d:%02d:%02d", tim->tm_yday + 1900 + YEAR_COMPENSATE, tim->tm_mon + 1, tim->tm_mday, tim->tm_hour, tim->tm_min, tim->tm_sec);
#endif
	return cur_time;
}
static double __get_printfTime_d()
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	double t = tv.tv_sec + (double)tv.tv_usec / (1000 * 1000);
	return t;
}

// system("color 0");
//#define mprintf(__format, ...) printf("\33[0;36mline:%d|\33[0;32mtime:%s(\33[0;32m%.6lf)|\33[0;32mpid:%d|\33[0;32mppid:%d\33[0;30m(\33[0;33m%s\33[0;30m)\33[0;35m--\33[0;31m" __format"\033[0m",__LINE__,__get_printfTime(),__get_printfTime_d(),getpid(),getppid(),__FUNCTION__, ##__VA_ARGS__)
/**
 @brief printf函数的扩展，输出添加时间，文件，行，pid，ppid，函数
 @param -参考printf函数
 @return 参考printf函数
*/
#define mprintf(format, ...)                                                                                                                                                                                      \
	do                                                                                                                                                                                                            \
	{                                                                                                                                                                                                             \
		if (DEBUG_MPRINTF_STATE)                                                                                                                                                                                  \
		{                                                                                                                                                                                                         \
            printf(GREEN"time:%s(%.6lf)"BOLDBLACK"|"RESET CYAN"%s:%d"BOLDBLACK"|"RESET YELLOW"pid:%d"BLUE"(%s)"MAGENTA"---"RESET format, __get_printfTime(), __get_printfTime_d(),__FILE__, __LINE__,  getpid(), __FUNCTION__, ##__VA_ARGS__); \
			fflush(stdout);                                                                                                                                                                                       \
		}                                                                                                                                                                                                         \
	} while (0)

#define mprintf1(format, ...)                                                                                                                                                                                      \
    do                                                                                                                                                                                                            \
    {                                                                                                                                                                                                             \
        if (DEBUG_MPRINTF_STATE)                                                                                                                                                                                  \
        {                                                                                                                                                                                                         \
            printf("\e[36m%s:%d|\e[32mtime:%s(%.6lf)|\e[33mpid:%d(%s)\e[35m---\e[0m" format, __FILE__, __LINE__, __get_printfTime(), __get_printfTime_d(), getpid(), __FUNCTION__, ##__VA_ARGS__); \
            fflush(stdout);                                                                                                                                                                                       \
        }                                                                                                                                                                                                         \
    } while (0)

// 公共日志文件描述符
static FILE* pbulic_log_fd = NULL;
// 日志对象个数
static int log_obj_count = 0;
// 公共日志输出
static int public_out_state = 2;

// 获取系统当前时间
char *__get_printfTime_L()
{
	static char cur_time[20];
    #ifdef __linux__
	struct timeval tv;
	gettimeofday(&tv, NULL); // 获取1970-1-1到现在的时间结果保存到tv中
	uint64_t sec = tv.tv_sec;
    //uint64_t min = tv.tv_sec / 60;
	struct tm cur_tm; // 保存转换后的时间结果
	localtime_r((time_t *)&sec, &cur_tm);
	snprintf(cur_time, 20, "%04d-%02d-%02d_%02d.%02d.%02d", cur_tm.tm_year + 1900, cur_tm.tm_mon + 1, cur_tm.tm_mday, cur_tm.tm_hour, cur_tm.tm_min, cur_tm.tm_sec);
    #else
    time_t curtime = time(0);
    struct tm *tim = localtime(&curtime);
    snprintf(cur_time, 20, "%d-%02d-%02d_%02d.%02d.%02d", tim->tm_yday + 1900 + YEAR_COMPENSATE, tim->tm_mon + 1, tim->tm_mday, tim->tm_hour, tim->tm_min, tim->tm_sec);
    #endif
    return cur_time;
}

/*************************************************
创建并打开文件，返回文件描述符
filename:文件名
state:0表示info,1表示public
**************************************************/
FILE* create_file(int state,const char *filename)
{
	if (filename == NULL)
		return NULL;
    char buff[130]={0};
    memcpy(buff, filename, strlen(filename));
    if(state == 0){
        strcat(buff, "/info/");
    } else {
        strcat(buff, "/public/");
    }
    strcat(buff, strcat(__get_printfTime_L(), ".txt"));
    if (0 != create_dir(buff))
        return NULL;
    if (access(buff, F_OK) != 0)
	{
        mprintf("file create,%s\n",buff);
		//int fd = open(filename, O_WRONLY | O_CREAT, 0644);
        FILE* fd = fopen(buff,"w");
        if(fd == NULL){
            mprintf("fopen %s:%s\n",buff,strerror(errno));
            fflush(stdout);
        }
		return fd;
    } else {
        mprintf("file exists,%s\n",buff);
        FILE* fd = fopen(buff,"a+");
        if(fd == NULL){
            mprintf("fopen %s:%s\n",buff,strerror(errno));
            fflush(stdout);
        }
        return fd;
    }
}

/*************************************************
创建目录
path:路径
**************************************************/
int create_dir(const char *path)
{
	if (path == NULL)
        return -1;
    umask(0);
	int i, len;
	len = strlen(path);
	char *dirname = (char *)malloc(len);
	memcpy(dirname, path, len);
	for (i = 0; i < len; i++)
	{
		if ('/' == dirname[i])
		{
			dirname[i] = '\0';
			if (access(dirname, F_OK) != 0)
			{
#ifdef __linux__
                mkdir(dirname, 0777);
#else
                mkdir(dirname);
#endif
			}
			dirname[i] = '/';
		}
    }
	free(dirname);
	return 0;
}
/*******************************************
*功能：创建日志对象
*参数：日志文件路径及前缀，如"./log/"将生成"./log/info/2021-11-24_14.36.10.txt;/log/public/2021-11-24_14.36.10.txt"这样的文件
*返回值：成功返回文件描述符，失败返回-1
********************************************/
LOG_OBJ_T *create_log_init(char *path)
{
	if(path == NULL)return NULL;
	
	LOG_OBJ_T *obj = (LOG_OBJ_T*)malloc(sizeof(LOG_OBJ_T));
	if(obj == NULL){
		mprintf("malloc:%s\n",strerror(errno));
		return NULL;
	}
	int len = (int)strlen(path);
    if(len > (int)(sizeof(obj->ro.filename)-30)){
        len = sizeof(obj->ro.filename)-30;
		mprintf("warning:input path lenght=%d > max=%d",(int)strlen(path),len);
	}
    memcpy(obj->ro.filename, path, len + 1);
    //strcat(obj->ro.filename, strcat(__get_printfTime_L(), ".txt"));
    obj->ro.fd = create_file(0,obj->ro.filename);
	if (obj->ro.fd == NULL)
	{
		mprintf("log init fail\n");
		free(obj);
		return NULL;
	}
	
	obj->ro.flag = 0;

	log_obj_count++;

	obj->func.destroy = close_log;
	obj->func.write_log = write_log;
	obj->func.set_log_value = set_log_value;

	///////////////////////////////////////////////////////////////////////////////////////////////
	// 初始化公共的日志文件
    if(pbulic_log_fd == NULL){
        pbulic_log_fd = create_file(1,obj->ro.filename);
		if(pbulic_log_fd == NULL){
			mprintf("log init fail\n");
		}
	}
	///////////////////////////////////////////////////////////////////////////////////////////////
	mprintf("init log obj success\n");
	return obj;
}

void close_log(LOG_OBJ_T *obj)
{
	if(obj == NULL)return;
	if (obj->ro.fd != NULL)
	{
		fclose(obj->ro.fd);
	}
	free(obj);

	log_obj_count--;
	// 删除公共日志对象
	if(log_obj_count <= 0){
		if(pbulic_log_fd != NULL){
			fclose(pbulic_log_fd);
			pbulic_log_fd = NULL;
		}
	}
}
// 设置日志选项,为0表示写到文件，为1表示直接输出到stdin,为2表示写到文件并输出到stdin
void set_log_value(LOG_OBJ_T *obj,int value)
{
	if(obj == NULL)return;
	obj->ro.flag = value;
}

void write_log(LOG_OBJ_T *obj,const char *data, const char *filename, const int line,const char *func)
{
	if(data == NULL || filename == NULL || func == NULL){
		return;
	}
	FILE* write_file_fp = NULL;
	int print_state = 1;
	if(obj == NULL){
        if(public_out_state == 0){
            print_state = 0;
            write_file_fp = pbulic_log_fd; // 输出到文件
        } else if(public_out_state == 2){
            write_file_fp = pbulic_log_fd; // 输出到文件
        }
	} else {
        if(obj->ro.flag == 0){
            print_state = 0;
            write_file_fp = obj->ro.fd; // 输出到文件
        } else if(obj->ro.flag == 2){
            write_file_fp = obj->ro.fd; // 输出到文件
        }
	}
	// 输出到stdout
	if(print_state){
		//mprintf("%s",data);
        printf(GREEN"time:%s(%.6lf)"BOLDBLACK"|"RESET CYAN"%s:%d"BOLDBLACK"|"RESET YELLOW"pid:%d"BLUE"(%s)"MAGENTA"---"RESET"%s\n",__get_printfTime(),__get_printfTime_d(), filename, line,  getpid(), func,data);
        fflush(stdout);
	}
	// 写到文件
	if(write_file_fp != NULL){

        long file_size = ftell(write_file_fp);
        if(log_file_max <= file_size){
            // 单个日志文件大小超限
            fclose(write_file_fp);
            if(obj != NULL){
                // 新建日志文件
                obj->ro.fd = create_file(0,obj->ro.filename);
                if (obj->ro.fd == NULL)
                {
                    mprintf("log init fail\n");
                    return ;
                }
                write_file_fp = obj->ro.fd;
            } else {
                // 新建日志文件
                pbulic_log_fd = create_file(1,obj->ro.filename);
                if(pbulic_log_fd == NULL){
                    mprintf("log init fail\n");
                    return;
                }
                write_file_fp = pbulic_log_fd;
            }
        }

		char *p = __get_printfTime_L();
		fwrite(p,1,strlen(p),write_file_fp); // 时间

		char buf[32];
		sprintf(buf, ":");
		fwrite(buf,1,strlen(buf),write_file_fp);
		fwrite(filename,1,strlen(filename),write_file_fp); // 文件名

		sprintf(buf, "-%d-",line);
		fwrite(buf,1,strlen(buf),write_file_fp); // 行号

		fwrite(func,1,strlen(func),write_file_fp); // 函数名

		sprintf(buf, "()---");
		fwrite(buf,1,strlen(buf),write_file_fp);
				
		fwrite(data,1,strlen(data),write_file_fp); // 数据

		if(data[strlen(data)-1] != '\n'){
			fwrite("\n",1,1,write_file_fp);
		}

		fflush(write_file_fp); // 刷新流
	}
}

void set_pub_log_out(int value)
{
	public_out_state = value;
}

void test_log_obj(){

	set_pub_log_out(2);

	LOG_OBJ_T *log_t = create_log_init("./log/info/");
	if(log_t != NULL){
		log_t->func.set_log_value(log_t,0);
		WRITE_LOG(log_t,"测试日志:%p\n",log_t);
	}
	WRITE_LOG(NULL,"测试日志:%p\n",log_t);
	log_t->func.destroy(log_t);
}
