#include "variabile.h"

std::ifstream fin("/home/teo/sorse/asc/proiect/project/tests/task2/add_get_delete_defragmentation/1.in");
//std::ifstream fin("1.in");
int abstract(int dimensiune)
{
    return ((dimensiune-1)/8)+1;
}
void print_mem()
{
    for(int linie=0; linie<=1023; linie++)
    {
        int fd_curent=0,start=-1,end;
        for(int i=0; i<=1023; i++)
        {
            //chiar ca vezi asta rescrii te rog io ftia
            //trb mutat printf
            if(v[linie][i] == 0)
            {
                if(start!=-1)
                {
                    printf("%d: ((%d, %d), (%d, %d))\n",fd_curent,linie,start,linie,end);
                    start=-1;
                }
            }
            else // v[linie][i] != 0
            {
                if(start == -1)//s-a gasit primul fd sau un fd dupa un gol
                {
                    start=i;
                    end=i;
                    fd_curent=v[linie][i];
                }
                else
                {
                    if(v[linie][i]==fd_curent){end=i;}
                    else//s-a gasit un nou fd imediat dupa alt fd
                    {
                        printf("%d: ((%d, %d), (%d, %d))\n",fd_curent,linie,start,linie,end);

                        start=i;
                        end=i;
                        fd_curent=v[linie][i];
                    }
                }
            }
        }
        if(end==1023)printf("%d: ((%d, %d), (%d, %d))\n",fd_curent,linie,start,linie,end);
    }
}
////extra
//
int input(char* text)
{
    bool fisier=true;
    bool extra=false;

    int temp;
    if(fisier)
    {
        fin>>temp;
    }
    else if(extra)
    {
        std::cout<<text;
        std::cin>>temp;
        std::cout<<std::endl;
    }
    else
    {
        std::cin>>temp;
    }

    return temp;
}
void print_vector()
{
    int counter=1;


    bool gol;//ca sa nu mai afiseze dupa n linii goale
    for(int linie=0; linie<1024; linie++, std::cout<<std::endl){
        gol=true;
        for(int i=0;i<1024;i++)
        {
            std::cout<<v[linie][i]<<' ';
            if(v[linie][i]!=0) gol=false;
        }
        if (gol) counter--;
        if(counter==0)break;
    }
    std::cout << std::endl<<std::endl;

}
