#ifndef LOG_INFO_H
#define LOG_INFO_H

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

// 该宏为0时，WRITE_LOG不做任何事
#define WRITE_LOG_VAILD_STATE	1

typedef struct _log_obj LOG_OBJ_T;
// 日志结构体
struct _log_obj{
	struct _rologobj{
		FILE* fd; // 文件描述符
		char filename[128]; // 日志文件路径
		int flag; // 为0表示写到文件，为1表示直接输出到stdin,为2表示写到文件并输出到stdin
	}ro;
	// 方法
	struct _funclogobj{
		// 设置日志选项,为0表示写到文件，为1表示直接输出到stdin,为2表示写到文件并输出到stdin
		void (*set_log_value)(LOG_OBJ_T *obj,int value);
		// 写data日志数据data，要写的日志信息;filename,调用的文件名__FILE__;line，调用的行数__LINE__;func调用函数__FUNCTION__
		void (*write_log)(LOG_OBJ_T *obj,const char *data, const char *filename, const int line,const char *func);
		// 删除日志对象
		void (*destroy)(LOG_OBJ_T *obj);
	}func;
};

#define ADTA_MAXSIZE 1024
//static char write_log_format_data[ADTA_MAXSIZE];
/**
 @brief 写日志
 @param obj-为对应的日志对象，当为NULL时，写入到公共日志文件(设置公共日志输出属性为可写到文件(set_pub_log_out(int)函数)，且公共日志管理对象存在(当构造第一个日志对象时生成公共日志对象，当删除最后一个日志对象时删除日志对象))
 @param more-参考printf函数
 */
#define WRITE_LOG(obj,__format, ...)                                                	\
		do                                                                              \
		{         																		\
			if(WRITE_LOG_VAILD_STATE){                                                  \
				char write_log_format_data[ADTA_MAXSIZE];                               \
				snprintf(write_log_format_data, ADTA_MAXSIZE, __format, ##__VA_ARGS__); \
                write_log(obj,write_log_format_data, __FILE__, __LINE__,__FUNCTION__);  \
			}																			\
		}while (0)

// 设置公共日志输出
// 0:写入到文件;
// 1:输出到stdout;
// 2:写入到文件和出到stdout
void set_pub_log_out(int value);

// 获取系统当前时间
char *__get_printfTime_L();

/*************************************************
创建并打开文件，返回文件描述符
filename:文件名
state:0表示info,1表示public
**************************************************/
FILE* create_file(int state,const char *filename);
/*************************************************
创建目录
path:路径
**************************************************/
int create_dir(const char *path);

/*******************************************
*功能：创建日志对象
*参数：日志文件路径及前缀，如"./log"将生成"./log/info/2021-11-24_14.36.10.txt"这样的文件
*返回值：成功返回文件描述符，失败返回-1。
********************************************/
LOG_OBJ_T *create_log_init(char *path);

/*******************************************
*功能：关闭日字文件
*返回值：无。
********************************************/
void close_log(LOG_OBJ_T *obj);

// 设置日志选项,为0表示写到文件，为1表示直接输出到stdin,为2表示写到文件并输出到stdin
void set_log_value(LOG_OBJ_T *obj,int value);

/*******************************************
向fd写入日志文件
参数：
	data，要写的日志信息
	filename,调用的文件名__FILE__
	line，调用的行数__LINE__
成功返回文件描述符，失败返回-1
********************************************/
void write_log(LOG_OBJ_T *obj,const char *data, const char *filename, const int line,const char *func);

#ifdef __cplusplus
}
#endif

#endif
