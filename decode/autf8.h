
#ifndef AUTF8_H
#define AUTF8_H

#ifdef __cplusplus
extern "C" {
#endif

int UTF8_getc(const unsigned char *str, int len, unsigned long *val);

int UTF8_putc(unsigned char *str, int len, unsigned long value);

#ifdef __cplusplus
}
#endif

#endif
