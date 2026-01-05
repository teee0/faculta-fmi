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
#define NR_THREADURI 5
int available_resources = MAX_RESOURCES;

int decrease_count(int count)
{
    if (available_resources < count) 
        return -1;
    else {
        available_resources -= count; 
        return 0; 
    }
}
int increase_count(int count)
{
    if (available_resources + count > MAX_RESOURCES) 
        return -1;
    else 
    {
        available_resources += count;
        return 0;
    }
}

void* inc (void* arg)
{
    int folosinta = rand() % MAX_RESOURCES;
    decrease_count(folosinta);
    
    printf ("s-au folosit %d,  mai sunt %d\n", 
            folosinta, available_resources);
    
    int a=0; loop(100000)a++;
    
    increase_count(folosinta);

    printf ("s-au eliberat %d, mai sunt %d\n", 
            folosinta, available_resources);

    return NULL;
}

int main()
{
//    test(pthread_mutex_init (&mtx, NULL));

    pthread_t th[NR_THREADURI];
    loop(NR_THREADURI) test(pthread_create(&th[i], NULL, inc, NULL));
    loop(NR_THREADURI) test(pthread_join(th[i],NULL));

//    pthread_mutex_destroy(&mtx);
}