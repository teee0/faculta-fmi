#include "add.h"

pair<int,int> add_intern(int descriptor, int dimensiune)
{
    auto rez = get0(dimensiune);
    if(rez.second-rez.first+1 >= dimensiune)
    {
        for (int i=0; i < /*vezi*/dimensiune; i++)
            v[rez.first+i]=descriptor;
        return make_pair(rez.first,rez.first+dimensiune-1);
    }
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
        auto rez = add_intern(descriptor,dimensiune);
        //print_vector();
        printf("%d: (%d, %d)\n",descriptor,rez.first,rez.second);
    }

}



