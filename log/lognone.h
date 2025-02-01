#ifndef LOGNONE_H
#define LOGNONE_H
#include "printFunction.h"

#ifdef __cplusplus
extern "C" {
#endif

// 初始化日志路径
// logDir:路径
// flushMs:日志保存刷新周期
// fileLogMaxSize:日志文件大小
int initLog(const char* logDir,unsigned int flushMs,unsigned int fileLogMaxSize);
void destinyLog();
// 设置日志保存级别
int setLogLevel(LOG_TYPE_ENUM level);
// 设置是否在标准输出(stdout)输出
void setLogPrint(int isPrint);

void writeLogformat(LOG_TYPE_ENUM level,const char* function,const char *file,const int line,const char* format, ...);
void writeLog(LOG_TYPE_ENUM level,const char* function,const char *file,const int line,const char* data);
void writeLognone(LOG_TYPE_ENUM level,const char* data);

#define ADTA_MAXSIZE 4096
#define WRITE_LOG(level,__format, ...) \
    do{ \
        char buffer[ADTA_MAXSIZE + 1]; \
        snprintf(buffer,ADTA_MAXSIZE,__format,##__VA_ARGS__); \
        writeLog(level,__FUNCTION__,__FILE__,__LINE__,buffer); \
    }while(0)

#define DEBUG_LOG(__format, ...)    WRITE_LOG(LOG_TYPE_ENUM_DEBUG,__format,##__VA_ARGS__)
#define WARRING_LOG(__format, ...)  WRITE_LOG(LOG_TYPE_ENUM_WARRING,__format,##__VA_ARGS__)
#define CRITICAL_LOG(__format, ...) WRITE_LOG(LOG_TYPE_ENUM_CRITICAL,__format,##__VA_ARGS__)
#define FATAL_LOG(__format, ...)    WRITE_LOG(LOG_TYPE_ENUM_FATAL,__format,##__VA_ARGS__)
#define INFO_LOG(__format, ...)     WRITE_LOG(LOG_TYPE_ENUM_INFO,__format,##__VA_ARGS__)

#define WRITE_LOG_FFL(level,func,file,line,__format, ...) \
do{ \
        char buffer[ADTA_MAXSIZE + 1]; \
        snprintf(buffer,ADTA_MAXSIZE,__format,##__VA_ARGS__); \
        writeLog(level,func,file,line,buffer); \
}while(0)

#define DEBUG_LOG_FFL(func,file,line,__format, ...)    WRITE_LOG_FFL(LOG_TYPE_ENUM_DEBUG,func,file,line,__format,##__VA_ARGS__)
#define WARRING_LOG_FFL(func,file,line,__format, ...)  WRITE_LOG_FFL(LOG_TYPE_ENUM_WARRING,func,file,line,__format,##__VA_ARGS__)
#define CRITICAL_LOG_FFL(func,file,line,__format, ...) WRITE_LOG_FFL(LOG_TYPE_ENUM_CRITICAL,func,file,line,__format,##__VA_ARGS__)
#define FATAL_LOG_FFL(func,file,line,__format, ...)    WRITE_LOG_FFL(LOG_TYPE_ENUM_FATAL,func,file,line,__format,##__VA_ARGS__)
#define INFO_LOG_FFL(func,file,line,__format, ...)     WRITE_LOG_FFL(LOG_TYPE_ENUM_INFO,func,file,line,__format,##__VA_ARGS__)


#ifdef __cplusplus
}
#endif

#endif // LOGNONE_H
