//#include "defrag.h"
//
//
//void defrag_intern()
//{
//    //dacă mai sunt goluri (daca nu, rez.second e 0 sau 1023)
//    while(1)
//    {
//        //in unidemnsional, orice gol nefinal e umplut la defragmentare
//        auto gol = get_intern(0);//vezi! ca asta e asa doar de exemplu schimb o
//        if(gol.second%1023 == 0) break;//get0
//        int fd_mutat = v[gol.second+1];
//
//        //df
//        auto next=get_intern(fd_mutat);
//
//        del_intern(fd_mutat);
//        for(int i=gol.first;i<=gol.first+next.second-next.first;i++)
//        {
//            v[i]=fd_mutat;//merge inlocuit cu un del intern mai general
//        }
//    }//vezi cum schimbi whileu
////vezi ca nu mere pt ultimu element (creca acm mere mistic magic)
//}
//void defrag()
//{
//    defrag_intern();
//    print_mem();
//}
