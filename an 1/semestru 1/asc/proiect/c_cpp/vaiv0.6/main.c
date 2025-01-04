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
char* f_write="((%d, %d), (%d, %d))\n";
char* f_write_fd="%hhu: ((%d, %d), (%d, %d))\n";

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
int main()
{
  scanf("%d", &nr_op);
  for (int i=nr_op; i > 0; i--)//se repeta de nr_op or
  {
    scanf("%d",&t_op);
    switch(t_op){
        //case 1: add(); break;
        //case 2: get(); break;
        //case 3: del(); break;
        //case 4: defrag(); break;
    }
  }
  return 0;
}
