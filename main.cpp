#include <stdio.h>
#include <string.h>
// #include "mList.h"
#include "log/lognone.h"
// #include "array/mArray.h"
#include "mem/mem_management.h"
#include "array/mArray_none.h"
#include "fft/fft.h"
#include "endian/endian.hpp"
#include <math.h>
#include <stdlib.h>
#include "decode/autf8.h"
#include "decode/base64.h"
#include "decode/beastSound.h"
#include <pthread.h>

static void cleanup_func_free(void **data)
{
	if(*data){
		printf("cleanup_func_free:%p\n",*data);
		free(*data);
	}
}

static void cleanup_func_mutex(void **mute)
{
	if(*mute){
		printf("cleanup_func_mute:%p\n",*mute);
		pthread_mutex_unlock((pthread_mutex_t *)*mute);
	}
}

// GNU中 C语言 实现RALL资源自动释放,适用于gcc,clang,不适用语msvc
// 当变量的生命周期结束时，会自动调用函数，实现内存释放。
// 注解:这里传入的是&name作为参数给cleanup_func_free函数
#define AUTOPTR(name,size) __attribute__((cleanup(cleanup_func_free))) void *name = malloc(size)
#define AUTOPTR_1 __attribute__((cleanup(cleanup_func_free))) void *

// 参数为已经初始化了的锁，且未上锁
// int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t *mutexattr);
// pthread_mutex_t mutex_lock=PTHREAD_MUTEX_INITIALIZER;
#define AUTOPTR_MUTEX(mutex) __attribute__((cleanup(cleanup_func_mutex))) void *_mutex = &mutex;pthread_mutex_lock((pthread_mutex_t*)_mutex)

unsigned char encrypt(unsigned char *p, unsigned int size, unsigned char key)
{
    for(unsigned int i=0; i<size; i++)
    {
        p[i] ^= key;
    }
    return (key^0x0A);
}

void decrypt(unsigned char *p, unsigned int size, unsigned char key)
{
    key ^= 0x0A;
    for(unsigned int i=0; i<size; i++)
    {
        p[i] ^= key;
    }
}

void creat_decode(const char *srcchr,const char* filename){
	//const char *srcchr = "94d2bc30d22368885183fd7e2e926b5d#13489071#/PicACG_2.2.1.3.3.4.apk";
	unsigned char srcdata[10000]={0};
	char dedatat[10000]={0};
	unsigned int lensrc=strlen(srcchr);
	memcpy(srcdata,srcchr,lensrc+1);

	unsigned char enkey=0x53;

	printf("encode:\n");
	for(int i=0;i<lensrc;i++)printf("%02x",srcdata[i]);printf("\n");

	unsigned char dekey = encrypt(srcdata,lensrc,enkey);
	printf("dekey=0x%02x\n",dekey);
	printf("decode:\n");
	for(int i=0;i<lensrc;i++)printf("0x%02x,",srcdata[i]);printf("\n");
	int lindex=0;
	lindex+=sprintf(dedatat+lindex,"unsigned char encode[] = {\n\t");
	for(int i=0;i<lensrc-1;i++){
		if(i>0 && i%10 == 0)lindex+=sprintf(dedatat+lindex,"\n\t");
		lindex+=sprintf(dedatat+lindex,"0x%02x,",srcdata[i]);
	}
	lindex+=sprintf(dedatat+lindex,"0x%02x};\n",srcdata[lensrc-1]);
	//printf("%s",dedatat);

	decrypt(srcdata,lensrc,dekey);

	printf("解码Hex：\n");
	for(int i=0;i<lensrc;i++)printf("%02x",srcdata[i]);printf("\n");
	printf("原始：%s\n",srcchr);
	printf("解码：%s\n",srcdata);

	char file_save[1024*100];
	int findex = 0;
	findex+=sprintf(file_save+findex,"#include <stdio.h>\n#include <string.h>\n");
	findex+=sprintf(file_save+findex,"void decrypt(unsigned char *p, unsigned int size, unsigned char key)\n{\n\
    key ^= 0x0A;\n\
    for(unsigned int i=0; i<size; i++)\n\
    {\n\
        p[i] ^= key;\n\
    }\n}\n");
	findex+=sprintf(file_save+findex,"int main(){\n\t");
	findex+=sprintf(file_save+findex,"%s",dedatat);
	findex+=sprintf(file_save+findex,"\tunsigned char dekey = 0x%02x;\n",enkey^0x0A); // dekey
	findex+=sprintf(file_save+findex,"\tdecrypt(encode,sizeof(encode),dekey);\n");
	findex+=sprintf(file_save+findex,"\tprintf(\"百度秒传链接：\");\n");
	findex+=sprintf(file_save+findex,"\tfor(int i=0;i<sizeof(encode);i++)printf(\"%%c\",encode[i]);printf(\"\\n\");\n");
	findex+=sprintf(file_save+findex,"\treturn 0;\n}\n");
	findex+=sprintf(file_save+findex,"\n");
	file_save[findex] = 0;
	
	printf("代码：\n");
	printf("%s",file_save);
	//const char* filename = "/storage/emulated/0/123.c";
	//const char* filename = "/storage/emulated/0/Download/WeiXin/123.c";
	FILE *fp = fopen(filename,"w");
	if(fp != NULL){
		printf("start save file:%s\n",filename);
		fwrite(file_save,1,findex,fp);
		fclose(fp);
	} else {
		perror("fopen");
	}
}

int main()
{
	initLog("./alllog",1000,1024*1024*10);
	setLogLevel(LOG_TYPE_ENUM_DEBUG);
	setLogPrint(1);

	// const char *srcchr = "94d2bc30d22368885183fd7e2e926b5d#13489071#/PicACG_2.2.1.3.3.4.apk";
	// unsigned char srcdata[100]={0};
	// unsigned int lensrc=strlen(srcchr);
	// memcpy(srcdata,srcchr,lensrc+1);
	// unsigned char enkey=0x53;
	// for(int i=0;i<lensrc;i++)printf("%02x",srcdata[i]);printf("\n");
	// unsigned char dekey = encrypt(srcdata,lensrc,enkey);//0x59
	// printf("dekey=0x%02x\n",dekey);
	// for(int i=0;i<lensrc;i++)printf("0x%02x,",srcdata[i]);printf("\n");
	// decrypt(srcdata,lensrc,dekey);
	// for(int i=0;i<lensrc;i++)printf("%02x",srcdata[i]);printf("\n");
	// printf("%s\n",srcchr);
	// printf("%s\n",srcdata);
	Array_None *array = init_array_none();
	if(array == NULL){
		return 0;
	}
	int i,cnt=1000*200;
	//int data[cnt];
	for(i=0;i<cnt;i++){
		//data[i] = i;
		//array->func.append(array,&data[i]);
		//DEBUG_LOG("mem_peruser=%d%%\n",mem_peruser());
		array->func.append(array,(void*)((long long)i));
	}

	DEBUG_LOG("swapb:data[3]=%lld,data[4]=%lld,data[5]=%lld\n",(long long)array->ro.index[3].data,(long long)array->ro.index[4].data,(long long)array->ro.index[5].data);
	array->func.swap(array,3,5);
	DEBUG_LOG("swape:data[3]=%lld,data[4]=%lld,data[5]=%lld\n",(long long)array->ro.index[3].data,(long long)array->ro.index[4].data,(long long)array->ro.index[5].data);
	array->func.swap(array,3,5);
	DEBUG_LOG("swape,moveb:data[3]=%lld,data[4]=%lld,data[5]=%lld\n",(long long)array->ro.index[3].data,(long long)array->ro.index[4].data,(long long)array->ro.index[5].data);
	array->func.move(array,3,5);
	DEBUG_LOG("data[3]=%lld,data[4]=%lld,data[5]=%lld\n",(long long)array->ro.index[3].data,(long long)array->ro.index[4].data,(long long)array->ro.index[5].data);
	array->func.move(array,3,5);
	DEBUG_LOG("data[3]=%lld,data[4]=%lld,data[5]=%lld\n",(long long)array->ro.index[3].data,(long long)array->ro.index[4].data,(long long)array->ro.index[5].data);
	DEBUG_LOG("\xf0\x9f\x92\x96 💖 \xf0\x9f\x92\x91 | \xe6\x9d\xa5 \u6765 来 | \xe5\x95\x8a \u554A 啊 | \x41 \u0041 A");
	//char *aa="💖";while(*aa){printf("%02x",*aa&0xff);aa++;}printf("\n");
	char aa[10]={0};
	unsigned int ad = 0xf09f9080-0x0100*16; //0xf09f9280;//96; // f09f9?80~bf(64个)
	unsigned int add,af;
	DEBUG_LOG("value\n");
	for(int m=0;m<32;m++){
		add = ad;
		printf("-----------------------------------0x%08X\n",add);
		for(int i=0;i<64;i++){
			if(i != 0 && i % 10 == 0)printf("\n");
			af = MEndian::ToBigEndian(add);
			memcpy(aa,&af,sizeof(af));
			aa[sizeof(af)] = 0;
			printf("%04X %s\t",af,aa);
			add++;	
		}
		printf("\n");
		ad += 0x0100;
	}
	unsigned char xaaa[10]={0};
	unsigned long value1 = UTF8_putc(xaaa,10,0x1f496);//0xf09f9296);
	DEBUG_LOG("xxxxxxxxx %lu %s\n",value1,xaaa);
	unsigned long val11;
	int clen = UTF8_getc(xaaa, 10, &val11);
	int val1 = val11;
	DEBUG_LOG("zzzzzzzzz %d %08x %s\n",clen,val1,xaaa);
	
	DEBUG_LOG("sssssssssssssssssssssssssssssssssssssss,%d\n",array->ro.count);
	for(i=0;i<array->ro.count;i++){
		//DEBUG_LOG("%p\n",array->ro.index[i].data);
	}
	DEBUG_LOG("mem_peruser=%f%%\n",mem_peruser());
	array->func.destroy(array);
	DEBUG_LOG("mem_peruser=%f%%\n",mem_peruser());
	DEBUG_LOG("cos(111)=%lf\n",cos(111));

	//fft_test();
	
	//creat_decode("94d2bc30d22368885183fd7e2e926b5d#13489071#/PicACG_2.2.1.3.3.4.apk","./123.c");

	{
	unsigned char *ptz[MEM_TABLE_SIZE]={0};
	int i=0;
	for(i=0;i<MEM_TABLE_SIZE;i++){
		ptz[i] = (unsigned char* )mem_malloc(MEM_BLOCK_SIZE*1111-1);
		printf("%u,%f%%\n",i,mem_peruser());
		if(ptz[i] == NULL){
			//printf("%u,%f%%\n",i,mem_peruser());
			break;
		}
	}
	printf("%f%%\n",mem_peruser());
	for(i=0;i<MEM_TABLE_SIZE;i++){
		if(ptz[i] != NULL){
			mem_free(ptz[i]);
			printf("%u,%f%%\n",i,mem_peruser());
		}
	}
	printf("%f%%\n",mem_peruser());
	}
	

	// srand(time(NULL));
	// List *list = init_list();
	// if(list == NULL){
	// 	return 0;
	// }
	// list->func.append(list,"aaaaaaaaaaa");
	// DEBUG_LOG("%d\n",list->count);
	// int i=0;
	// for(i=0;i<list->count;i++){
	// 	DEBUG_LOG("%s\n",(char*)list->index[i]->data);
	// }
	// list->func.delete(list);

	// Array *array = init_array();
	// if(array == NULL){
	// 	return 0;
	// }

	

	// for(i=0;i<100;i++){
	// 	int *data = (int*)malloc(4);
	// 	*data = i;
	// 	array->func.append(array,data);
	// }

	// //array->func.swap(array,1,3);
	// array->func.move(array,3,5);
	
	// DEBUG_LOG("sssssssssssssssssssssssssssssssssssssss\n");
	// for(i=0;i<array->ro.count;i++){
	// 	DEBUG_LOG("%d\n",*(int*)array->ro.index[i].data);
	// }
	// array->func.destroy_d(array);
	int mm = 0x12345678;
	int nn;
	nn = MEndian::ToBigEndian(mm);
	DEBUG_LOG("ToBigEndian:0x%08x,mm=%08x,%02x\n",nn,mm,((char*)&mm)[0]);
	nn = MEndian::ToLittleEndian(mm);
	DEBUG_LOG("ToLittleEndian:0x%08x\n",nn);
	struct type_test{
		unsigned char mm[256];
	} type_s,type_d;
	for(int i=0;i<sizeof(struct type_test);i++)type_s.mm[i] = i;
	type_d = MEndian::ToBigEndian(type_s);
	DEBUG_LOG("ToBigEndian:");
	for(int i=0;i<sizeof(struct type_test);i++)printf("%02d ",type_d.mm[i]);printf("\n");
	type_d = MEndian::ToLittleEndian(type_s);
	DEBUG_LOG("ToLittleEndian:");
	for(int i=0;i<sizeof(struct type_test);i++)printf("%02d ",type_d.mm[i]);printf("\n");

	// 隐式转换 char,short -> int ;有符号->无符号
	short sa=-1;
	unsigned short usa=2;
	int sb=-1;
	unsigned int usb=2;
	long long c;
	c= sa*usa;
	INFO_LOG("0x%04x 0x%04x 0x%08x 0x%08x\n",sa,usa,sb,usb);
	WARRING_LOG("%lld %llx\n",c,c);
	c=sb*usb;
	CRITICAL_LOG("%lld %llx\n",c,c);
	FATAL_LOG("-------------------------\n");
	INFO_LOG("vvvvvvvvvvvv\n");

	char str[] = "ManMan💖 \xf0\x9f\x92\x91";
	char *ptr = toBase64((unsigned char*)str,sizeof(str));
	if(ptr != NULL){
		INFO_LOG("%s,len=%d\n",ptr,(int)strlen(ptr));
		unsigned int le;
		char *cptr = fromBase64(ptr,strlen(ptr),&le);
		if(cptr!= NULL){
			INFO_LOG("len:%d\n",le);
			for(int i=0;i<le;i++){
				printf("%c",cptr[i]);
			}
			printf("\n");
			free(cptr);
		}
		free(ptr);
	}

	DEBUG_PRINT_LOG("");
	srand(NULL);
	#define MAX_SIZE 101
	unsigned char *src = (unsigned char *)malloc(MAX_SIZE);
	for(int i=0;i<5;i++){
		for(int j=0;j<MAX_SIZE;j++){
			src[j] = rand()%256;
			printf("%02x",src[j]);
		}
		printf("\n");

		char *ptr = toBase64((unsigned char*)src,MAX_SIZE);
		if(ptr!= NULL){
			DEBUG_LOG("%s,len=%d\n",ptr,(int)strlen(ptr));
			unsigned int le;
			char *cptr = fromBase64(ptr,strlen(ptr),&le);
			if(cptr!= NULL){
				INFO_LOG("len:%d\n",le);
				for(int i=0;i<le;i++){
					printf("%02x",cptr[i]&0xff);
				}
				printf("\n");
				free(cptr);
			}
			free(ptr);
		}
	}
	free(src);
	DEBUG_PRINT_LOG("");

	{
		const char *utf8src = "123nna你好";
		//const char *dict[4] = {"0","1","2","3"};//{"嗷","呜","啊","~"};
		const char *dict[4] = {"嗷","呜","啊","~"};
		char *pp = toBeastSound_2byte((const unsigned char *)utf8src,strlen(utf8src),dict);
		if(pp!= NULL){
			DEBUG_PRINT_LOG("%s\n",pp);
			char *ppp = fromBeastSound_2byte((const unsigned char *)pp,strlen(pp));
			if(ppp!= NULL){
				DEBUG_PRINT_LOG("%s\n",ppp);
				free(ppp);
			}
			free(pp);
		}
	}
	const char *utf8src = "💖💖你好𐌰𰃺𰀀";
	//const char *dict[4] = {"0","1","2","3"};//{"嗷","呜","啊","~"};
	const char *dict[4] = {"嗷","呜","啊","~"};
	char *pp = toBeastSound_4byte((const unsigned char *)utf8src,strlen(utf8src),dict);
	if(pp!= NULL){
		DEBUG_PRINT_LOG("%s\n",pp);
		char *ppp = fromBeastSound_4byte((const unsigned char *)pp,strlen(pp));
		if(ppp!= NULL){
			DEBUG_PRINT_LOG("%s\n",ppp);
			free(ppp);
		}
		free(pp);
	}

	{
		char srcdata[] = "\u2764\ufe0f❤️💖💖你好𐌰𰃺𰀀\1\2\3\4\5";//
		//const char *dict[4] = {"0","1","2","3"};//{"嗷","呜","啊","~"};
		const char *dict[4] = {"嗷","呜","啊","~"};
		char *pp = toBeastSound(srcdata,sizeof(srcdata),dict);
		if(pp!= NULL){
			DEBUG_PRINT_LOG("%s\n",pp);
			int destsize;
			char *ppp = fromBeastSound((const char *)pp,strlen(pp),&destsize);	
			if(ppp!= NULL){
				DEBUG_PRINT_LOG("%d,%s\n",destsize,ppp);
				for(int i=0;i<destsize;i++){
					printf("%02x",ppp[i]&0xff);
				}
				printf("\n");
				free(ppp);
			}
			free(pp);
		}
	}

	pthread_mutex_t mutex_lock=PTHREAD_MUTEX_INITIALIZER;
	{
		AUTOPTR(p,100); // p会在生命周期结束后释放
		AUTOPTR_1 p1 = malloc(20);
		DEBUG_PRINT_LOG("p=%p,p1=%p\n",p,p1);
		AUTOPTR_MUTEX(mutex_lock);
		DEBUG_PRINT_LOG("mutex_lock:%p\n",&mutex_lock);
	}
	pthread_mutex_destroy(&mutex_lock);

	{
		const char *tb = "酱雾纱雾雾酱酱酱纱匠雾匠酱匠酱纱酱酱酱雾酱匠纱匠酱雾雾酱纱酱雾纱纱酱酱纱纱纱雾匠纱匠酱雾纱雾雾酱雾匠酱匠纱匠雾纱雾酱酱酱纱酱雾雾雾酱酱纱纱纱雾匠雾雾匠雾纱雾雾匠雾纱雾匠纱匠雾酱纱匠匠酱纱酱雾纱纱酱匠纱纱纱雾匠雾纱酱雾纱雾雾酱纱匠纱匠纱匠雾纱纱匠雾酱纱酱雾纱纱酱雾纱纱纱雾匠纱雾雾雾纱雾雾酱纱匠纱匠纱匠雾纱纱雾纱酱纱酱雾雾纱纱酱纱纱纱雾匠雾匠纱雾纱雾雾匠纱雾雾匠纱匠雾纱纱酱匠酱纱酱雾雾纱酱匠纱纱纱雾匠纱纱纱雾纱雾雾匠纱雾匠匠纱匠雾纱雾酱匠酱纱酱雾纱纱酱匠纱纱纱雾雾雾雾纱雾纱雾雾酱纱雾纱匠纱匠雾酱雾酱酱酱纱酱雾纱酱纱匠纱纱纱雾雾匠匠酱雾纱雾雾匠酱匠纱匠纱匠雾酱酱酱雾酱纱酱雾纱酱纱雾纱纱纱雾雾酱酱雾雾纱雾雾酱纱酱雾匠纱匠雾酱酱纱纱酱纱酱雾雾纱雾纱纱纱纱雾雾匠酱纱雾纱雾雾酱纱酱雾匠纱匠雾酱雾酱酱酱纱酱雾纱匠酱匠纱纱纱雾匠纱纱纱雾纱雾雾匠雾酱匠匠纱匠雾酱匠纱匠酱纱酱雾纱匠纱匠纱纱纱雾雾纱纱纱雾纱雾雾匠匠匠匠匠纱匠雾纱纱纱匠酱纱酱雾纱雾酱匠纱纱纱雾匠雾纱酱雾纱雾雾酱雾酱匠匠纱匠雾纱纱酱酱酱纱酱雾纱雾酱纱纱纱纱雾雾雾雾雾雾纱雾雾匠雾匠雾匠纱匠雾酱雾酱匠酱纱酱雾纱雾纱匠纱纱纱雾纱匠酱雾匠雾酱匠匠雾酱酱酱雾匠匠酱匠雾匠匠酱酱纱酱酱匠雾纱纱纱雾雾纱纱酱雾纱雾雾酱纱酱酱匠纱匠雾纱雾酱酱酱纱酱雾雾雾纱酱纱纱纱雾匠雾纱酱雾纱雾雾酱雾匠匠匠纱匠雾酱雾雾雾酱纱酱雾纱纱酱匠纱纱纱雾雾纱纱匠雾纱雾雾酱雾雾酱匠纱匠雾纱纱酱纱酱纱酱雾雾纱酱雾纱纱纱雾雾纱纱雾雾纱雾雾酱雾匠纱匠纱匠雾纱雾纱纱酱纱酱雾雾纱纱纱纱纱纱雾匠雾雾雾雾纱雾雾酱纱纱匠匠纱匠雾酱纱匠雾酱纱酱雾雾纱纱匠纱纱纱雾匠纱纱雾雾纱雾雾匠纱雾匠匠纱匠雾纱雾酱匠酱纱酱雾纱纱酱匠纱纱纱雾雾雾雾纱雾纱雾雾匠雾匠匠匠纱匠雾酱雾纱雾酱纱酱雾纱雾雾纱纱纱纱雾雾雾酱纱雾纱雾雾匠雾匠酱匠纱匠雾酱雾雾纱酱纱酱雾纱雾酱酱纱纱纱雾雾雾雾纱雾纱雾雾酱纱酱纱匠纱匠雾纱纱纱纱酱纱酱雾纱雾纱酱纱纱纱雾纱匠酱雾匠匠匠纱纱酱雾酱酱雾酱纱雾酱纱雾酱纱酱雾纱雾纱雾纱纱纱雾雾雾雾雾雾纱雾雾匠雾匠匠匠纱匠雾酱雾酱匠酱纱酱雾纱纱酱酱匠纱匠匠纱纱雾匠匠雾匠纱酱匠纱匠匠纱匠雾酱匠纱酱酱纱酱雾纱酱匠纱纱纱纱雾雾匠雾雾雾纱雾雾匠匠酱酱匠纱匠雾酱匠雾酱酱纱酱雾酱匠匠雾匠";
		char *ppp = fromBeastSound_2byte((const unsigned char *)tb,strlen(tb));
		if(ppp!= NULL){
			DEBUG_PRINT_LOG("%p,%s\n",ppp,ppp);
			free(ppp);
		}

		AUTOPTR_1 p = fromBeastSound_2byte((const unsigned char *)tb,strlen(tb));
		if(p!= NULL){
			DEBUG_PRINT_LOG("%p,%s\n",p,p);
		}
	}

	{
		const char *tb = "我";
		unsigned long unicode;
		if(0 < UTF8_getc((const unsigned char *)tb,strlen(tb),&unicode)){
			DEBUG_PRINT_LOG("%04lx\n",unicode);
			char gbk[3]={0};
			if(0 <= unicode2gbk(unicode,(const char*)gbk)){
				DEBUG_PRINT_LOG("%02x,%02x,%s\n",gbk[0]&0xff,gbk[1]&0xff,gbk);
				if(0 <= gbk2unicode(gbk,&unicode)){
					DEBUG_PRINT_LOG("%04lx\n",unicode);
				}
			}
		}
	}

	destinyLog();

	return 0;
}
