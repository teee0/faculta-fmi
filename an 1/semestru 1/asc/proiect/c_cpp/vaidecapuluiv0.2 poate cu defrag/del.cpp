#include "del.h"

void del_intern(int descriptor)
{//aparent trebuie tinut cont de fds si n del
    int rez_linie;
    auto rez = get_intern(descriptor,rez_linie);
    if(rez.second!=0)
        for(int i=rez.first; i<=rez.second; i++)
        {
            v[rez_linie][i]=0;
        }
    int gasit = false;
    for(int i=0; i<255 && fds[i]!=0; i++)
    {
        if(fds[i]==descriptor)
        {
            gasit=true;
        }
        if(gasit)
            fds[i]=fds[i+1];
    }
    cate_fd -= 1;
}

void del()
{
    int descriptor;
    descriptor = input("fd: ");
    del_intern(descriptor);
    print_mem();
}

