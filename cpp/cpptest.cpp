#include "cpptest.hpp"
#include <iostream>
#include "../log/printFunction.h"

using namespace std;

CPPTEST_T::CPPTEST_T()
{
    cout<<"CPP"<<endl;
    DEBUG_PRINT_LOG("\n");
}

CPPTEST_T::~CPPTEST_T()
{
    DEBUG_PRINT_LOG("\n");
}

void CPPTEST_T::test()
{
    cout<<"CPP"<<endl;
    DEBUG_PRINT_LOG("\n");
}


