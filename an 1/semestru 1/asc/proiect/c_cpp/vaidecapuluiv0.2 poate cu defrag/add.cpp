#include "add.h"

int fds[255];
int cate_fd=0;

pair<int,int> add_intern(int descriptor, int dimensiune, int &ret_linie)
{
    ret_linie=0;
    for (; ret_linie <= 1023; ret_linie++ )
    {
        auto rez = get0_linie(dimensiune,ret_linie);
        if(rez.second-rez.first+1 >= dimensiune)
        {
            //contorizare oridine descriptore
            cate_fd++;
            fds[cate_fd]=descriptor;//dis dont work btw ca ar treb sa tii cont de ce linie e pus si na
            //plasare in vector
            for (int i=0; i < /*vezi*/dimensiune; i++)
                v[ret_linie][rez.first+i]=descriptor;
            return make_pair(rez.first,rez.first+dimensiune-1);
        }
    }
    ret_linie=0;
    return make_pair(0,0);
}

void add()//n + pe urmatoarele 2N linii veti primi, succesiv,
        //descriptorul de fisier, respectiv dimensiunea in kB
{
    int n, descriptor, dimensiune;
    n=input("câte add-uri: ");

    for(int i=0;i<n;i++)
    {
        descriptor=input("fd: ");
        dimensiune=input("size: ");
        dimensiune=abstract(dimensiune);//vezi asta

        int linie;//tre sa fie schimbat de fctie
        auto rez = add_intern(descriptor,dimensiune,linie);
        //print_vector();
        printf("%d: ((%d, %d), (%d, %d))\n",descriptor,linie,rez.first,linie,rez.second);
    }

}



