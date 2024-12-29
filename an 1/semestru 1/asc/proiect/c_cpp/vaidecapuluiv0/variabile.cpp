#include "variabile.h"

std::ifstream fin("1.in");
int abstract(int dimensiune)
{
    return ((dimensiune-1)/8)+1;
}
void print_mem()
{
    int fd_curent=0,start=-1,end;
    for(int i=0; i<=1023; i++)
    {
        //chiar ca vezi asta rescrii te rog io ftia
        //trb mutat printf
        if(v[i] == 0)
        {
            if(start!=-1)
            {
                printf("%d: (%d, %d)\n",fd_curent,start,end);
                start=-1;
            }
        }
        else // v[i] != 0
        {
            if(start == -1)//s-a gasit primul fd sau un fd dupa un gol
            {
                start=i;
                end=i;
                fd_curent=v[i];
            }
            else
            {
                if(v[i]==fd_curent){end=i;}
                else//s-a gasit un nou fd imediat dupa alt fd
                {
                    printf("%d: (%d, %d)\n",fd_curent,start,end);

                    start=i;
                    end=i;
                    fd_curent=v[i];
                }
            }
        }
    }
    if(end==1023) printf("%d: (%d, %d)\n",fd_curent,start,end);
}
//extra

int input(char* text)
{
    bool fisier=false;
    bool extra=false;

    int temp;
    if(fisier)
        fin>>temp;

    else if(extra)
        std::cout<<text;
    std::cin>>temp;

    return temp;
}
void print_vector()
{
    for(int i=0;i<1024;i++)std::cout<<v[i]<<' ';
    std::cout << std::endl<<std::endl;
}
