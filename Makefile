#
# Makefile
#
# -Wall显示所有警告(-W显示编译器认为会错误的警告) -w关闭所有警告

# -fPIC 表示编译为位置独立的代码

# -shared 该选项指定生成动态连接库
# ar cqs log_info.a log_info.o 生成静态库
# 可以使用 ar -t libname.a 来查看一个静态库由那些.o文件构成。
# 可以使用 ar q libname.a xxx1.o xxx2.o xxx3.o ... xxxn.o 生成静态库

# 在Linux下，动态库和静态库同事存在时，gcc/g++的链接程序，默认链接的动态库
# -WI,-Bstatic -llibname //指定让gcc/g++链接静态库
# -WI,-Bdynamic -llibname //指定让gcc/g++链接动态库
# -static参数，将所有的库以静态的方式链入可执行程序，这样生成的可执行程序，不再依赖任何库

# nm工具可以打印出库中的涉及到的所有符号，这里的库既可以是静态的也可以是动态的

# gcc -E test.c -o test.i 预处理
# gcc -S test.i -o test.s 汇编
# gcc -c test.s -o test.o 编译
# gcc test.o -o test 链接


#CROSS_COMPILE := arm-linux-gnueabihf-
CROSS_COMPILE := 
CPP = $(CROSS_COMPILE)g++
CC = $(CROSS_COMPILE)gcc
OBJDUMP := $(CROSS_COMPILE)objdump
AR := $(CROSS_COMPILE)ar

BIN = ./testgm.exe
VPATH = 

#TOP_DIR = $(shell pwd)
#OBJ_DIR = $(TOP_DIR)/obj
TOP_DIR = .
OBJ_DIR = $(TOP_DIR)/obj

MAINSRC = main.c

# C编译参数
C_FLAGS += -W #-Wall
#C_FLAGS += -Wshadow -Wundef -Wmaybe-uninitialized
# 指定源文件类型为C
# C_FLAGS += -x c
# 指定窄字符串常量以GBK编码存储
#C_FLAGS += -fexec-charset=GBK
# 优化等级
C_FLAGS += -O3 -g3
# C版本
#C_FLAGS += -std=c99
#C_FLAGS += -march=armv5te
#C_FLAGS += -lstdc++
C_FLAGS += -fPIC

# CPP 编译参数
CXX_FLAGS += -W #-Wall
#CXX_FLAGS += -Wshadow -Wundef -Wmaybe-uninitialized
# 指定源文件类型为CPP
# CXX_FLAGS += -x c++
CXX_FLAGS := -O3 -g3
CXX_FLAGS += -fPIC

#LIBS  += -L./db -lsqlite3
#LIBS += -Bstatic -lsqlite3
#LIBS  += -ldl
#LIBS += -lpthread
#LIBS += -lstdc++

#LIBS := -L$(shell pwd) -les_3000gm
#LIBS := -L. -les_3000gm

# 运行时库路径
LIBS += -Wl,-rpath=./
LIBS += -lm
#LIBS = ./libes_3000gm.so
#LIBS += -lstdc++
#LIBS += -static

# 头文件
INCDIRS 		:= ./
INCDIRS 		+= ./array
INCDIRS 		+= ./list
INCDIRS 		+= ./log
INCDIRS 		+= ./mem
INCDIRS 		+= ./cpp
INCDIRS 		+= ./fft
INCDIRS 		+= ./decode
# 源文件
SRCDIRS			:= ./
SRCDIRS 		+= ./array
SRCDIRS 		+= ./list
SRCDIRS 		+= ./log
SRCDIRS 		+= ./mem
SRCDIRS 		+= ./cpp
SRCDIRS 		+= ./fft
SRCDIRS 		+= ./decode

INCLUDE			:= $(patsubst %, -I %, $(INCDIRS))
# INCLUDE := 

CFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.c))
CFILENDIR		:= $(notdir  $(CFILES))
COBJS			:= $(patsubst %, $(OBJ_DIR)/%, $(CFILENDIR:.c=.o))

CPPFILES		:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.cpp))
CPPFILENDIR		:= $(notdir  $(CPPFILES))
CPPOBJS			:= $(patsubst %, $(OBJ_DIR)/%, $(CPPFILENDIR:.cpp=.o))

# $(info $(COBJS))
# $(info $(CPPOBJS))

OBJS			:= $(COBJS) $(CPPOBJS)

# Makefile执行make的搜索环境变量，根据这个变量搜索文件
VPATH			:= $(SRCDIRS)

.PHONY: clean

# obj dir
LIB_DIR := $(TOP_DIR)/lib
$(shell if [ ! -e $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR);fi)
LIB_DIR_STATIC := $(LIB_DIR)/static
$(shell if [ ! -e $(LIB_DIR_STATIC) ]; then mkdir -p $(LIB_DIR_STATIC);fi)
LIB_DIR_SHARED := $(LIB_DIR)/shared
$(shell if [ ! -e $(LIB_DIR_SHARED) ]; then mkdir -p $(LIB_DIR_SHARED);fi)

# make -n

$(BIN) : $(OBJS)
	$(CPP) $^ -o $@ $(LIBS)
	$(OBJDUMP) -d $@ > $@.dis
	$(OBJDUMP) -h $@ > $@.lds
	$(OBJDUMP) -p $@ > $@.ld
	mv $(OBJ_DIR)/*.a $(LIB_DIR_STATIC)
	mv $(OBJ_DIR)/*.so $(LIB_DIR_SHARED)

$(COBJS) : $(OBJ_DIR)/%.o : %.c
#	$(CC) $(C_FLAGS) $(INCLUDE) -c $< -o $@
	$(CC) $(C_FLAGS) $(INCLUDE) -E $< -o $@.i
	$(CC) $(C_FLAGS) $(INCLUDE) -S $@.i -o $@.s
	$(CC) $(C_FLAGS) $(INCLUDE) -c $@.s -o $@
#	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $< -o $@
	$(OBJDUMP) -d $@ > $@.dis
#	$(CC) $(C_FLAGS) $(INCLUDE) $< -shared -fPIC -o $@.so
	$(CC) -shared -o $@.so $@
	$(AR) cqs $@.a $@
$(CPPOBJS) : $(OBJ_DIR)/%.o : %.cpp
#	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $< -o $@
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -E $< -o $@.i
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -S $@.i -o $@.s
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $@.s -o $@
	$(OBJDUMP) -d $@ > $@.dis
#	$(CPP) $(C_FLAGS) $(INCLUDE) $< -shared -o $@.so
	$(CPP) -shared -o $@.so $@
	$(AR) cqs $@.a $@

clean:
	$(info "clean file")
	rm -rf $(BIN) $(BIN).dis $(BIN).lds $(BIN).ld $(COBJS) $(CPPOBJS) $(OBJ_DIR) $(LIB_DIR) 123.*
