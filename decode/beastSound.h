#ifndef BESTSOUND_H
#define BESTSOUND_H

#ifdef __cplusplus
extern "C" {
#endif

/*
    转换为兽音语言编码,适用于2byte内的Unicode字符,兼容公用编码
    utf8src: 源数据,为utf-8编码
    len: 源数据长度
    dict: 兽音语言编码字典,为一个长度为4的数组,每个元素为一个字符串,表示一个兽音语言编码字符
    return: 兽音语言编码数据
*/
char *toBeastSound_2byte(const unsigned char *utf8src, int len,const char *dict[4]);
/*
    转换为utf-8编码,适用于2byte内的Unicode字符,兼容公用编码
    beastsound: 兽音语言编码数据
    len: 兽音语言编码数据长度
    dict: 兽音语言编码字典,为一个长度为4的数组,每个元素为一个字符串,表示一个兽音语言编码字符
    return: utf-8编码数据
*/
char *fromBeastSound_2byte(const unsigned char *beastsound, int len,const char *dict[4]);

/*
    转换为兽音语言编码
    utf8src: 源数据,为utf-8编码
    len: 源数据长度
    dict: 兽音语言编码字典,为一个长度为4的数组,每个元素为一个字符串,表示一个兽音语言编码字符
    return: 兽音语言编码数据
*/
char *toBeastSound(const unsigned char *utf8src, int len,const char *dict[4]);
/*
    转换为utf-8编码
    beastsound: 兽音语言编码数据
    len: 兽音语言编码数据长度
    dict: 兽音语言编码字典,为一个长度为4的数组,每个元素为一个字符串,表示一个兽音语言编码字符
    return: utf-8编码数据
*/
char *fromBeastSound(const unsigned char *beastsound, int len,const char *dict[4]);

#ifdef __cplusplus
}
#endif
#endif