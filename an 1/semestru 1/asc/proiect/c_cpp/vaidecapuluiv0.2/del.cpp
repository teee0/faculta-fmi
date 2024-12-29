#include "del.h"

void del_intern(int descriptor)
{
    int rez_linie;
    auto rez = get_intern(descriptor,rez_linie);
    if(rez.second!=0)
        for(int i=rez.first; i<=rez.second; i++)
        {
            v[rez_linie][i]=0;
        }
}

void del()
{
    int descriptor;
    descriptor = input("fd: ");
    del_intern(descriptor);
    print_mem();
}

