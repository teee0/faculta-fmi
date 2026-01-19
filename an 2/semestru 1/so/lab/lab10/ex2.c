#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <semaphore.h>
#define loop(i, n) for (int i = 0; i < n; i++)
#define test(e) \
    { if(e) {        \
        perror(NULL);\
        return errno;\
    }}

#define NR_THREADURI 7
int nr_apelari = -NR_THREADURI;

pthread_mutex_t sem_mtx;
int N;

void init(int n)
{
    pthread_mutex_init (&sem_mtx, NULL);
    N=n;
}

void barrier_point()
{
    pthread_mutex_lock(&sem_mtx);
    nr_apelari++;
    pthread_mutex_unlock(&sem_mtx);
    while(nr_apelari != N);
    printf ("ceva %d",time(NULL));  
}

void * tfun ( void * v )
{
    int * tid = ( int *) v ;
    printf ("%d reached the barrier \n " , *tid );
    barrier_point();
    printf ("%d passed the barrier \n " , *tid );
    free ( tid );
    return NULL;
}

int main()
{
    pthread_t th[NR_THREADURI];

    loop(i, NR_THREADURI) 
    { 
        int* x = malloc(sizeof(int));
        test(pthread_create(&th[i], NULL, tfun, x=&i));
        
    loop(i, NR_THREADURI) test(pthread_join(th[i],NULL));

    pthread_mutex_destroy(&sem_mtx);
}