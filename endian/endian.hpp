#ifndef SWCP_H
#define SWCP_H

class MEndian
{
public:
    MEndian(){};

    const static short m=0x1234;
    /*
     * 转为大端序数据
     * value:一般为16,32,64位的数据
     * */

    template <typename T> static inline T ToBigEndian(T value)
    {
        if(*(unsigned char*)&m == 0x34){
            int value_len = sizeof(T);
            T value_t;
            char *p = (char *)&value_t;
            char *q = (char *)&value;
            for(int i=0;i<value_len;i++){
                p[i] = q[value_len-1-i];
            }
            return value_t;
        } else {
            return value;
        }
    }
    /*
     * 转为小端序数据
     * value:一般为16,32,64位的数据
     * */
    template <typename T> static inline T ToLittleEndian(T value)
    {
        if(*(unsigned char*)&m == 0x12){
            int value_len = sizeof(T);
            T value_t;
            char *p = (char *)&value_t;
            char *q = (char *)&value;
            for(int i=0;i<value_len;i++){
                p[i] = q[value_len-1-i];
            }
            return value_t;
        } else {
            return value;
        }
    }
    /*
     * 将来自小端序的数据转为本机字节序
     * value:一般为16,32,64位的数据
     * */
    template <typename T> static inline T FromLittleEndian(T value)
    {
        if(*(unsigned char*)&m == 0x12){
            int value_len = sizeof(T);
            T value_t;
            char *p = (char *)&value_t;
            char *q = (char *)&value;
            for(int i=0;i<value_len;i++){
                p[i] = q[value_len-1-i];
            }
            return value_t;
        } else {
            return value;
        }
    }
    /*
     * 将来自大端序的数据转为本机字节序
     * value:一般为16,32,64位的数据
     * */
    template <typename T> static inline T FromBigEndian(T value)
    {
        if(*(unsigned char*)&m == 0x34){
            int value_len = sizeof(T);
            T value_t;
            char *p = (char *)&value_t;
            char *q = (char *)&value;
            for(int i=0;i<value_len;i++){
                p[i] = q[value_len-1-i];
            }
            return value_t;
        } else {
            return value;
        }
    }
};

#endif // SWCP_H
