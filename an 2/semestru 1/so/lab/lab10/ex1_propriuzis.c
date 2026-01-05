#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#define loop(n) for (int i = 0; i < n; i++)
#define test(e) \
    { if(e) {        \
        perror(NULL);\
        return errno;\
    }}

#define MAX_RESOURCES 5
#define NR_THREADURI 7
int available_resources = MAX_RESOURCES;
pthread_mutex_t sem_mtx;
int decrease_count(int count)
{
    while (available_resources < count);
    pthread_mutex_lock(&sem_mtx);
    available_resources -= count; 
    printf ("s-au folosit %d,  mai sunt %d\n", 
            count, available_resources);
    pthread_mutex_unlock(&sem_mtx);
    return 0; 
}
int increase_count(int count)
{
    /*if (available_resources + count > MAX_RESOURCES) 
        return -1;
    else 
    {*/
        pthread_mutex_lock(&sem_mtx);
        available_resources += count;
        printf ("s-au eliberat %d, mai sunt %d\n", 
                count, available_resources);
        pthread_mutex_lock(&sem_mtx);
        return 0;
    //}
}

void* inc (void* arg)
{
    int folosinta = rand() % MAX_RESOURCES;
    while(!decrease_count(folosinta));
    
    int a=0; loop(100000)a++;
    
    increase_count(folosinta);

    return NULL;
}

int main()
{
    test(pthread_mutex_init (&sem_mtx, NULL));

    pthread_t th[NR_THREADURI];
    loop(NR_THREADURI) test(pthread_create(&th[i], NULL, inc, NULL));
    loop(NR_THREADURI) test(pthread_join(th[i],NULL));

    pthread_mutex_destroy(&sem_mtx);
}