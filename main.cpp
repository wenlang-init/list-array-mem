#include <stdio.h>
#include <string.h>
// #include "mList.h"
#include "log/log_info.h"
// #include "array/mArray.h"
#include "mem/mem_management.h"
#include "array/mArray_none.h"
#include "fft/fft.h"
#include "endian/endian.hpp"
#include <math.h>
#include <stdlib.h>

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
		//WRITE_LOG(NULL,"mem_peruser=%d%%\n",mem_peruser());
		array->func.append(array,(void*)((long long)i));
	}

	//array->func.swap(array,1,3);
	array->func.move(array,3,5);
	WRITE_LOG(NULL,"\xf0\x9f\x92\x96 💖 | \xe6\x9d\xa5 \u6765 来 | \xe5\x95\x8a \u554A 啊 | \x41 \u0041 A");
	WRITE_LOG(NULL,"%x",0x554A);
	//char *aa="💖";while(*aa){printf("%02x",*aa&0xff);aa++;}printf("\n");
	
	WRITE_LOG(NULL,"sssssssssssssssssssssssssssssssssssssss,%d\n",array->ro.count);
	for(i=0;i<array->ro.count;i++){
		//WRITE_LOG(NULL,"%p\n",array->ro.index[i].data);
	}
	WRITE_LOG(NULL,"mem_peruser=%d%%\n",mem_peruser());
	array->func.destroy(array);
	WRITE_LOG(NULL,"mem_peruser=%d%%\n",mem_peruser());
	WRITE_LOG(NULL,"cos(111)=%lf\n",cos(111));

	fft_test();
	
	creat_decode("94d2bc30d22368885183fd7e2e926b5d#13489071#/PicACG_2.2.1.3.3.4.apk","./123.c");

	// unsigned char *ptz[MEM_TABLE_SIZE]={0};
	// int i=0;
	// for(i=0;i<MEM_TABLE_SIZE;i++){
	// 	ptz[i] = mem_malloc(129);
	// 	if(ptz[i] == NULL){
	// 		mprintf("%u,%u\n",i,mem_peruser());
	// 		break;
	// 	}
	// }
	// mprintf("%d\n",mem_peruser());
	// for(i=0;i<MEM_TABLE_SIZE;i++){
	// 	if(ptz[i] != NULL){
	// 		mem_free(ptz[i]);
	// 		//mprintf("%u,%d\n",i,mem_peruser());
	// 	}
	// }
	// mprintf("%d\n",mem_peruser());
	

	// srand(time(NULL));
	// List *list = init_list();
	// if(list == NULL){
	// 	return 0;
	// }
	// list->func.append(list,"aaaaaaaaaaa");
	// WRITE_LOG(NULL,"%d\n",list->count);
	// int i=0;
	// for(i=0;i<list->count;i++){
	// 	WRITE_LOG(NULL,"%s\n",(char*)list->index[i]->data);
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
	
	// WRITE_LOG(NULL,"sssssssssssssssssssssssssssssssssssssss\n");
	// for(i=0;i<array->ro.count;i++){
	// 	WRITE_LOG(NULL,"%d\n",*(int*)array->ro.index[i].data);
	// }
	// array->func.destroy_d(array);
	int mm = 0x12345678;
	int nn;
	nn = MEndian::ToBigEndian(mm);
	WRITE_LOG(NULL,"ToBigEndian:0x%08x\n",nn);
	nn = MEndian::ToLittleEndian(mm);
	WRITE_LOG(NULL,"ToLittleEndian:0x%08x\n",nn);
	struct type_test{
		unsigned char mm[256];
	} type_s,type_d;
	for(int i=0;i<sizeof(struct type_test);i++)type_s.mm[i] = i;
	type_d = MEndian::ToBigEndian(type_s);
	WRITE_LOG(NULL,"ToBigEndian:");
	for(int i=0;i<sizeof(struct type_test);i++)printf("%02d ",type_d.mm[i]);printf("\n");
	type_d = MEndian::ToLittleEndian(type_s);
	WRITE_LOG(NULL,"ToLittleEndian:");
	for(int i=0;i<sizeof(struct type_test);i++)printf("%02d ",type_d.mm[i]);printf("\n");
	return 0;
}
