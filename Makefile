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

# 交叉编译工具链前缀
#CROSS_COMPILE := arm-linux-gnueabihf-
CROSS_COMPILE := 
# C++编译器
CPP = $(CROSS_COMPILE)g++
# C编译器
CC = $(CROSS_COMPILE)gcc
# 反汇编工具
OBJDUMP := $(CROSS_COMPILE)objdump
# 静态库打包工具
AR := $(CROSS_COMPILE)ar

# 可执行文件名称
BIN = ./testgm.exe
# Makefile搜索源文件的路径
VPATH = 

# 项目根目录
TOP_DIR = .
# 目标文件目录
OBJ_DIR = $(TOP_DIR)/obj

# 主源文件
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
# 生成位置独立的代码
C_FLAGS += -fPIC

# CPP 编译参数
CXX_FLAGS += -W #-Wall
#CXX_FLAGS += -std=c++11
#CXX_FLAGS += -Wshadow -Wundef -Wmaybe-uninitialized
# 指定源文件类型为CPP
# CXX_FLAGS += -x c++
# 优化等级和调试信息
CXX_FLAGS := -O3 -g3
# 生成位置独立的代码
CXX_FLAGS += -fPIC

# 链接库参数
#LIBS  += -L./db -lsqlite3
#LIBS += -Bstatic -lsqlite3
#LIBS  += -ldl
#LIBS += -lpthread
#LIBS += -lstdc++
#LIBS := -L$(shell pwd) -les_3000gm
#LIBS := -L. -les_3000gm
# 运行时库路径
LIBS += -Wl,-rpath=./
# 链接数学库
LIBS += -lm
# 链接线程库
LIBS += -lpthread
#LIBS = ./libes_3000gm.so
#LIBS += -lstdc++
#LIBS += -static

# 头文件目录
INCDIRS 		:= ./
INCDIRS 		+= ./array
INCDIRS 		+= ./list
INCDIRS 		+= ./log
INCDIRS 		+= ./mem
INCDIRS 		+= ./cpp
INCDIRS 		+= ./fft
INCDIRS 		+= ./decode
#INCDIRS 		+= ./method
#INCDIRS 		+= ./sql
# 源文件目录
SRCDIRS			:= ./
SRCDIRS 		+= ./array
SRCDIRS 		+= ./list
SRCDIRS 		+= ./log
SRCDIRS 		+= ./mem
SRCDIRS 		+= ./cpp
SRCDIRS 		+= ./fft
SRCDIRS 		+= ./decode
#SRCDIRS 		+= ./method
#SRCDIRS 		+= ./sql

# 头文件包含参数
INCLUDE			:= $(patsubst %, -I %, $(INCDIRS))
# INCLUDE := 

# 查找所有C源文件
CFILES			:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.c))
# 提取C源文件的文件名
CFILENDIR		:= $(notdir  $(CFILES))
# 生成C目标文件列表
COBJS			:= $(patsubst %, $(OBJ_DIR)/%, $(CFILENDIR:.c=.o))

# 查找所有C++源文件
CPPFILES		:= $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.cpp))
# 提取C++源文件的文件名
CPPFILENDIR		:= $(notdir  $(CPPFILES))
# 生成C++目标文件列表
CPPOBJS			:= $(patsubst %, $(OBJ_DIR)/%, $(CPPFILENDIR:.cpp=.o))

# 所有目标文件列表
OBJS			:= $(COBJS) $(CPPOBJS)

# Makefile执行make的搜索环境变量，根据这个变量搜索文件
VPATH			:= $(SRCDIRS)

# 伪目标，不对应实际文件
.PHONY: clean

# 库文件目录
LIB_DIR := $(TOP_DIR)/lib
# 创建目标文件目录
$(shell if [ ! -e $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR);fi)
# 静态库目录
LIB_DIR_STATIC := $(LIB_DIR)/static
# 创建静态库目录
$(shell if [ ! -e $(LIB_DIR_STATIC) ]; then mkdir -p $(LIB_DIR_STATIC);fi)
# 动态库目录
LIB_DIR_SHARED := $(LIB_DIR)/shared
# 创建动态库目录
$(shell if [ ! -e $(LIB_DIR_SHARED) ]; then mkdir -p $(LIB_DIR_SHARED);fi)

# 生成可执行文件的规则
$(BIN) : $(OBJS)
	$(CPP) $^ -o $@ $(LIBS)
	$(OBJDUMP) -d $@ > $@.dis
	$(OBJDUMP) -h $@ > $@.lds
	$(OBJDUMP) -p $@ > $@.ld
	mv $(OBJ_DIR)/*.a $(LIB_DIR_STATIC)
	mv $(OBJ_DIR)/*.so $(LIB_DIR_SHARED)

# 生成C目标文件的规则
$(COBJS) : $(OBJ_DIR)/%.o : %.c
#	$(CC) $(C_FLAGS) $(INCLUDE) -c $< -o $@
	$(CC) $(C_FLAGS) $(INCLUDE) -E $< -o $@.i
	$(CC) $(C_FLAGS) $(INCLUDE) -S $@.i -o $@.s
	$(CC) $(C_FLAGS) $(INCLUDE) -c $@.s -o $@
#	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $< -o $@
	$(OBJDUMP) -d $@ > $@.dis
#	$(CC) $(C_FLAGS) $(INCLUDE) $< -shared -fPIC -o $@.so
	$(CC) -shared -o $@.so $@
	$(AR) rcs $@.a $@

# 生成C++目标文件的规则
$(CPPOBJS) : $(OBJ_DIR)/%.o : %.cpp
#	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $< -o $@
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -E $< -o $@.i
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -S $@.i -o $@.s
	$(CPP) $(CXX_FLAGS) $(INCLUDE) -c $@.s -o $@
	$(OBJDUMP) -d $@ > $@.dis
#	$(CPP) $(C_FLAGS) $(INCLUDE) $< -shared -o $@.so
	$(CPP) -shared -o $@.so $@
	$(AR) rcs $@.a $@

# 清理生成的文件
clean:
	$(info "clean file")
	rm -rf $(BIN) $(BIN).dis $(BIN).lds $(BIN).ld $(COBJS) $(CPPOBJS) $(OBJ_DIR) $(LIB_DIR) 123.*
