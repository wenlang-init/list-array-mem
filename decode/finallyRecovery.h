#ifndef FINALLYRECOVERY_H
#define FINALLYRECOVERY_H

#include <stdio.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

// 计算结构体成员的偏移量
#define GETVARIATEOFFSET(type,member) (size_t)(&((type*)0)->member)
// 获取结构体成员的类型
#define GETVARIATETYPE(type,member) (typeof(((type*)0)->member))
// 获取结构体成员的大小
#define GETVARIATESIZE(type,member) (sizeof(((type*)0)->member))
// 获取结构体大小
#define GETSTRUCTSIZE(type) (sizeof(type))
// 获取数组个数
#define GETSTRUCTCNT(type) (sizeof(type)/sizeof(type[0]))

static void cleanup_func_free(void **data)
{
	if(*data){
		//printf("cleanup_func_free:%p\n",*data);
		free(*data);
	}
}

// GNU中 C语言 实现RALL资源自动释放,适用于gcc,clang,不适用语msvc
// 当变量的生命周期结束时，会自动调用函数，实现内存释放。
// 注解:这里传入的是&name作为参数给cleanup_func_free函数
#define AUTOPTRNEW(name,size) __attribute__((cleanup(cleanup_func_free))) void *name = malloc(size)
#define AUTOPTRTYPENEWSIZE(type,name,size) __attribute__((cleanup(cleanup_func_free))) void *void##_name = malloc(size);type *name = (type *)void##_name
#define AUTOPTRTYPENEWCNT(type,name,cnt) __attribute__((cleanup(cleanup_func_free))) void *void##_name = malloc(cnt*sizeof(type));type *name = (type *)void##_name
#define AUTOPTRTYPE(type) __attribute__((cleanup(cleanup_func_free))) typeof(type) *
#define AUTOPTR __attribute__((cleanup(cleanup_func_free))) void *

#if 1
#include <pthread.h>
static void cleanup_func_mutex(void **mute)
{
	if(*mute){
		//printf("cleanup_func_mute:%p\n",*mute);
		pthread_mutex_unlock((pthread_mutex_t *)*mute);
	}
}

// 参数为已经初始化了的锁，且未上锁
// int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t *mutexattr);
// pthread_mutex_t mutex_lock=PTHREAD_MUTEX_INITIALIZER;
#define AUTOPTR_MUTEX(mutex) __attribute__((cleanup(cleanup_func_mutex))) void *_mutex = &mutex;pthread_mutex_lock((pthread_mutex_t*)_mutex)
#endif

#ifdef __cplusplus
}

#endif

#endif // FINALLYRECOVERY_H