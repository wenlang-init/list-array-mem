
#ifndef AUTF8_H
#define AUTF8_H

#ifdef __cplusplus
extern "C" {
#endif

/*
 * UTF-8 to Unicode
 *
 * @param str: UTF-8 字符串
 * @param len: 字符串长度
 * @param val: Unicode 数据
 * @return: UTF-8字的长度, 失败返回负值
 */
int UTF8_getc(const unsigned char *str, int len, unsigned long *val);

/*
 * Unicode to UTF-8
 *
 * 注意: 目标字符串长度必须大于等于 6 字节
 *
 * @param str: 目标字符串
 * @param len: 目标字符串长度
 * @param val: Unicode 数据
 * @return: 写入的字节数, 失败返回负值
*/
int UTF8_putc(unsigned char *str, int len, unsigned long value);

#ifdef __cplusplus
}
#endif

#endif
