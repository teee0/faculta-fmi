#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// o fac hardcodat ca mi se pare irelevant ex-ului 
// sa adaug 20 de linii de cod
// pt alocare dinamica si pasat de argumente
#define M 3
#define N 3
#define P 3
int a [M][P] = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
int b [P][N]={
    {1,0,0},
    {0,1,0},
    {0,0,1}
};
int c [M][N];

void* calc_unic(void* args)
{
    int *as = (int*)args;
    int i=as[0], j=as[1];

    for (int k = 0; k < P; k++)
    {
        c[i][j] += a[i][k] * b[k][j];
    }
    free(args);
    return NULL;
}

int main(int nr_arg, char** v_arg)
{

    char* str=v_arg[1];

    

    pthread_t* threads;
    int contor = 0;

    threads = (pthread_t*)malloc(N*M*sizeof(pthread_t));
    
    for (int i=0; i<M; i++)
        for (int j=0; j<N; j++)
        {
            int *args = (int*)malloc(2*sizeof(int));//am adaugat asta si acu mere
            args[0]=i, args[1]=j;
            pthread_create(&threads[contor++], NULL, calc_unic, args);
        }
    
    for (int i=0; i<N*M; i++)
        pthread_join(threads[i], NULL);


    


    //afiseaza C
    for (int i=0; i<M; i++, putchar('\n'))
        for (int j=0; j<N; j++)
        {
            printf ("%d ", c[i][j]);
        }

    return 0;
}