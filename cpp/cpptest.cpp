#include "cpptest.hpp"
#include <iostream>
#include "../log/log_info.h"

using namespace std;

CPPTEST_T::CPPTEST_T()
{
    cout<<"CPP"<<endl;
    WRITE_LOG(NULL,"\n");
}

CPPTEST_T::~CPPTEST_T()
{
    WRITE_LOG(NULL,"\n");
}

void CPPTEST_T::test()
{
    cout<<"CPP"<<endl;
    WRITE_LOG(NULL,"\n");
}


