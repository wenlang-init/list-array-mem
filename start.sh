#!/bin/bash

printComplieCmd(){
    echo -e "\e[1;36m${BASH_SOURCE[1]}->${BASH_SOURCE[0]}(${BASH_LINENO[0]}|${FUNCNAME[1]}->${FUNCNAME[0]})\e[0m"
    echo -e "\e[36m\t$1\e[0m"
    #echo -e "\e[36m${BASH_SOURCE[1]}->${BASH_SOURCE[0]}(${BASH_LINENO[0]}|${FUNCNAME[1]}->${FUNCNAME[0]}) $1\e[0m"
    #sleep 0.1
    # 数组的0号成员是当前执行的脚本，1号成员是调用当前脚本的脚本 ${BASH_SOURCE[@]}
    # 输出结果为一个数组，第一个是被调用的函数名称，第二个是调用的函数名称 ${FUNCNAME[@]}
    # 数组的0号成员是调用的行，1号成员是当前相对行号 ${BASH_LINENO[@]}
    # 当前行号 ${LINENO}
    # local a=${FUNCNAME[@]}
    # echo "\e[36m$a\e[0m"
}

cpu=$(cat /proc/cpuinfo | grep processor | wc -l)

make clean

date1=$(date +"%Y-%m-%d %H:%M:%S")

make -j${cpu}

date2=$(date +"%Y-%m-%d %H:%M:%S")
compiletime=`expr $(date -d "$date2" +%s) - $(date -d "$date1" +%s)`
printComplieCmd "编译时间 ${compiletime}s\n\t开始时间 $date1\n\t结束时间 $date2"

./testgm.exe
gcc -Wall -O3 -g3 -fPIC  -E 123.c -o 123.o.i
gcc -Wall -O3 -g3 -fPIC  -S 123.o.i -o 123.o.s
gcc -Wall -O3 -g3 -fPIC  -c 123.o.s -o 123.o
objdump -d 123.o > 123.o.dis
gcc -shared -o 123.o.so 123.o
ar cqs 123.o.a 123.o
gcc 123.o -o 123.exe
./123.exe

#make clean