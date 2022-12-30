#include <stdio.h>
#include <string.h>
// #include "mList.h"
#include "log/log_info.h"
// #include "array/mArray.h"
#include "mem/mem_management.h"
#include "array/mArray_none.h"
#include "fft/fft.h"
#include <math.h>
unsigned char encrypt(unsigned char *p, unsigned int size, unsigned char key);
void decrypt(unsigned char *p, unsigned int size, unsigned char key);

void creat_decode(){
	const char *srcchr = "7607901a010ecde2d22b2a4a9444828a#1893527031#hypno.7z\nda00919e6c5ba98b81776abefcb0f290#371349772#hypnoappAndroid.7z\n6e8e4a893323ad5c5b8cf19fcea45849#2600#save.rar";
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


	printf("代码：\n");
	// printf("#include <stdio.h>\n#include <string.h>\n");
	// printf("void decrypt(unsigned char *p, unsigned int size, unsigned char key)\n{\n\
    // key ^= 0x0A;\n\
    // for(unsigned int i=0; i<size; i++)\n\
    // {\n\
    //     p[i] ^= key;\n\
    // }\n}\n");

	// printf("int main(){\n\t");
	// printf("%s",dedatat);
	// printf("\tunsigned char dekey = 0x%02x;\n",enkey^0x0A); // dekey
	// printf("\tdecrypt(encode,sizeof(encode),dekey);\n");
	// printf("\tprintf(\"百度秒传链接：\");\n");
	// printf("\tfor(int i=0;i<sizeof(encode);i++)printf(\"%%c\",encode[i]);printf(\"\\n\");\n");
	// printf("\treturn 0;\n}\n");

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
	printf("%s",file_save);

	FILE *fp = fopen("./123.c","w");
	if(fp != NULL){
		fwrite(file_save,1,findex,fp);
		fclose(fp);
	} else {
		perror("fopen");
	}
}

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

int testt(){

	creat_decode();

	unsigned char encode[] = {0x6a,0x67,0x37,0x61,0x31,0x30,0x60,0x63,0x37,0x61,0x61,0x60,0x65,0x6b,0x6b,0x6b,0x66,0x62,0x6b,0x60,0x35,
	0x37,0x64,0x36,0x61,0x36,0x6a,0x61,0x65,0x31,0x66,0x37,0x70,0x62,0x60,0x67,0x6b,0x6a,0x63,0x64,0x62,0x70,0x7c,0x03,0x3a,0x30,0x12,
	0x10,0x14,0x0c,0x61,0x7d,0x61,0x7d,0x62,0x7d,0x60,0x7d,0x60,0x7d,0x67,0x7d,0x32,0x23,0x38};
	unsigned char dekey = 0x59;
	decrypt(encode,sizeof(encode),dekey);
	printf("百度秒传链接：");
	for(int i=0;i<sizeof(encode);i++)printf("%c",encode[i]);printf("\n");
	return 0;
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
	testt();
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
	return 0;
}
