#include "defrag.h"


void defrag_intern()
{
    //dacă mai sunt goluri (daca nu, rez.second e 0 sau 1023)
    while(1)
    {
        //in unidemnsional, orice gol nefinal e umplut la defragmentare
        auto gol = get0();//vezi!
        if(gol.second%1023 == 0) break;
        int fd_mutat = v[gol.second+1];

        //df
        auto next=get_intern(fd_mutat);

        del_intern(fd_mutat);
        for(int i=gol.first;i<=gol.first+next.second-next.first;i++)
        {
            v[i]=fd_mutat;
        }
    }//vezi cum schimbi whileu
}
void defrag()
{
    defrag_intern();
    print_mem();
}
