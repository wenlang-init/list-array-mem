#!/bin/sh

make clean
make -j16
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