#include "del.h"

void del_intern(int descriptor)
{
    auto rez = get_intern(descriptor);
    if(rez.second!=0)
        for(int i=rez.first; i<=rez.second; i++)
        {
            v[i]=0;
        }
}

void del()
{
    int descriptor;
    descriptor = input("fd: ");
    del_intern(descriptor);
    print_mem();
}

