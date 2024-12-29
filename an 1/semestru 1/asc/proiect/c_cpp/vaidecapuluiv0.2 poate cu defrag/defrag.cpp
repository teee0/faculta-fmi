#include "defrag.h"


void defrag_intern()//un picuțâră tsarbomba da na
{
    for(int i=0; i<255 && fds[i]!=0; i++)
    {
        int rez_linie;
        auto rez = get_intern(fds[i], rez_linie);
        if(rez.second != 0)// s-a găsit
        {
            del_intern(fds[i]);
            add_intern(fds[i],rez.second-rez.first+1,rez_linie);
        }
    }
}
void defrag()
{
    defrag_intern();
    print_mem();
}
