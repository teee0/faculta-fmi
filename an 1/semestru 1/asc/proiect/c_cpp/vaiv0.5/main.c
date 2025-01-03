#include <stdio.h>
#include <stdbool.h>//doar pt extra
//#include <stdarg.h>
typedef unsigned char byte;

//variabile
byte v[1024];
///var. citite
//in main
int t_op;
int nr_op=0;
//in add, get, del
byte descriptor;
int dimensiune;//modificat de abstract
int start,end;//modificat de get_intern, ask
int nr_add;
//formate
char* f_write="(%d, %d)\n";
char* f_write_fd="%hhu: (%d, %d)\n";

bool extra=false;
/*void input(char* text,char* format,...)
{
    if(extra)puts(text);

    va_list args
    va_start(args,format);
    if (format=="%d")
    {
        scanf(format, va_arg(args,int));
    }
    else if(format=="%hhu")
    else puts("behold the consequences of ur actions")
    scanf("%d", x);
}let this be a warning*/
/*
void input(char* text, void* x)
{
    if(extra)puts(text);
    if(sizeof(*x)==sizeof(int))
        scanf("%d", (int*)x);
    else if(sizeof(*x)==sizeof(byte))
        scanf("%hhu", (byte*)x);
    //mai scriu eu c telepatic din sicriu ca pe vremea lu s.c.m.
}*/
void print_mem()
{
    int fd_curent=0;
    start=-1;
    for(int i=0; i<=1023; i++)
    {
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
    if(start!=-1&&end==1023) printf("%d: (%d, %d)\n",fd_curent,start,end);
}

void print_vector()
{
    for(int i=0;i<1024;i++)printf("%d ",v[i]);
    puts("\n\n");
}

//  GET

void get_intern(byte descriptor)
{
    start=-1;
    end=-1;

    for(int i=0; i<= 1023; i++)
    {
        if(v[i]==descriptor)
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
void get()
{
    scanf("%hhu",&descriptor);
    get_intern(descriptor);
    printf(f_write, start, end);
}
int spatiu;

//returneaza intervalu in care se gaseste prima secventa de 0 de lungime "minim"
void ask/*get0*/(int minim)
{
    start=-1;
    end=-1;

    for(int i=0; i<= 1023; i++)
    {
        if(v[i] == 0)
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
    for(int i=start; i <= end; i++)
    {
        v[i]=fd_nou;
    }
}
//  ADD
void abstract()
{
    dimensiune=(dimensiune-1)/8+1;
}

void add_intern(byte descriptor, int dimensiune)
{
    ask(dimensiune);
    if(end!=0)
    {
        end = start+dimensiune-1;
        put(descriptor);
    }
}
void add()
{
    scanf("%d", &nr_add);
    for (int _ = 0; _<nr_add; _++)
    {
        scanf("%hhu", &descriptor);
        scanf("%d", &dimensiune);

        abstract();
        add_intern(descriptor,dimensiune);

        printf(f_write_fd, descriptor, start, end);
    }
}

void del_intern(int descriptor)
{
    //nu modifica start si end pt ca mor
    int t_start=start, t_end=end;
    get_intern(descriptor);
    if(end!=0)
        put(0);
    start=t_start;
    end=t_end;
}

void del()
{
    scanf("%hhu", &descriptor);
    del_intern(descriptor);//parametrii sunt degeaba
    print_mem();
}

void defrag_intern()
{
    while(1)
    {
        //in unidemnsional, orice gol nefinal e umplut la defragmentare
        ask(0);
        int prim_gol=start;
        if(end%1023 == 0) break;
        int fd_mutat = v[end+1];

        //df
        get_intern(fd_mutat);

        del_intern(fd_mutat);

        end=prim_gol+end-start;
        start=prim_gol;

        put(fd_mutat);
    }
}
void defrag()
{
    defrag_intern();
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
        case 4: defrag(); break;
    }
  }
  return 0;
}
