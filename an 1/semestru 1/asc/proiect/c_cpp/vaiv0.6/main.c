#include <stdio.h>
typedef unsigned char byte;

//variabile
byte v[1024][1024];
///var. citite
//in main
int t_op;
int nr_op=0;
//in add, get, del
byte descriptor;
int dimensiune;//modificat de abstract
int start,end;//modificat de get_intern, ask
int linie;
int nr_add;
//formate
char* f_write_nofd="((%d, %d), (%d, %d))\n";
char* f_write_fd="%hhu: ((%d, %d), (%d, %d))\n";
//atrocități
int spatiu;
byte fd_curent;

void print_vector()
{
    int counter=1;

    int gol;//ca sa nu mai afiseze dupa n linii goale
    for(int linie=0; linie<1024; linie++)
    {
        gol = 1;
        for(int i=0;i<1024;i++)
        {
            printf("%d ",v[linie][i]);
            if(v[linie][i]!=0) gol = 0;
        }

        puts("\n\n");

        if (gol == 0) counter--;
        if(counter==0)break;
    }


}
void print_fd()
{
    printf(f_write_fd,descriptor,linie,start,linie,end);
}
void print_nofd()
{
    printf(f_write_nofd,linie,start,linie,end);
}

void print_mem()// practic nemodificat din 0.2
{
    int temp=descriptor;
    for(linie=0; linie<=1023; linie++)
    {
        descriptor=0;
        start=-1;
        for(int i=0; i<=1023; i++)
        {
            if(v[linie][i] == 0)
            {
                if(start!=-1)
                {
                    print_fd();
                    start=-1;
                }
            }
            else // v[linie][i] != 0
            {
                if(start == -1)//s-a gasit primul fd sau un fd dupa un gol
                {
                    start=i;
                    end=i;
                    descriptor=v[linie][i];
                }
                else
                {
                    if(v[linie][i]==descriptor){end=i;}
                    else//s-a gasit un nou fd imediat dupa alt fd
                    {
                        print_fd();

                        start=i;
                        end=i;
                        descriptor=v[linie][i];
                    }
                }
            }
        }
        if(start!=-1 && end==1023)print_fd();
    }
    descriptor=temp;
}

int abstract()
{
    dimensiune=(dimensiune-1)/8+1;
}

/// GET
void get_intern_linie(/*byte descriptor*/)//get_intern 0.5 modificat doar la acc. v
{
    start=-1;
    end=-1;

    for(int i=0; i<= 1023; i++)
    {
        if(v[linie][i]==descriptor)
        {
            if(start == -1) start=i;
            end = i;
        }
    }

    if(start==-1)
    {
        start=0;
        end=0;
    }
}
void get_intern(/*byte descriptor, int linie*/)
{
    for (linie=0;linie<=1023;linie++)
    {
        get_intern_linie();
        if(end != 0)
            return;
    }
    linie=0;
}
void get(/*byte descriptor*/)
{
    scanf("%hhu",&descriptor);
    get_intern();
    print_nofd();
}



/// ADD
///nu există ask() din motive f clare pe care le am uitat
///add_intern_linie nu e folosit direct pt ca e inutil
void ask_linie/*get0*/(int minim)
{
    start=-1;
    end=-1;

    for(int i=0; i<= 1023; i++)
    {
        if(v[linie][i] == 0)
        {
            if(start == -1)
                start=i;
            end = i;
        }
        else
        {
            if(start != -1)
            {
                spatiu = end-start+1;
                if(minim <= spatiu)
                {
                     break;
                }
                else
                {
                    start = -1;
                    end = -1;
                }
            }
        }
    }
    spatiu = end-start+1;
    if(start==-1 || minim > spatiu)
    {
        start=0;
        end=0;
    }
}//returneaza intervalu in care se gaseste prima secventa de 0 de lungime minima data

void put(int fd_nou)
{
    fd_curent=fd_nou;//this is changed so it s the same as in asm not the other way around
    for(int i=start; i <= end; i++)
    {
        v[linie][i]=fd_curent;
    }
}

void add_intern_linie(/*byte descriptor, int dimensiune, int linie*/)
{
    ask_linie(dimensiune);
    if(end!=0)
    {
        end = start+dimensiune-1;
        put(descriptor);
    }
}

void add_intern(/*byte descriptor, int dimensiune*/)
{
    for (linie=0; linie <= 1023; linie++ )
    {
        add_intern_linie();
        if (end!=0) return;
    }
    linie=0;
}

void add()//n + pe urmatoarele 2N linii veti primi, succesiv,
        //descriptorul de fisier, respectiv dimensiunea in kB
{
    scanf("%d", &nr_add);

    for(int _ = 0; _ < nr_add; _ ++)
    {
        scanf("%hhu", &descriptor);
        scanf("%d", &dimensiune);

        abstract();

        add_intern();

        print_fd();
    }

}

/// DEL

void del_intern(/*int descriptor*/)
{
    get_intern();
    if(end!=0)
        put(0);
}

void del()
{
    scanf("%hhu", &descriptor);
    del_intern();
    print_mem();
}




int main()
{
  scanf("%d", &nr_op);
  for (int i=nr_op; i > 0; i--)//se repeta de nr_op or
  {
    scanf("%d",&t_op);
    switch(t_op){
        case 1: add(); break;
        case 2: get(); break;
        case 3: del(); break;
        //case 4: defrag(); break;
    }
  }
  return 0;
}
