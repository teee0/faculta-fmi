#include <stdio.h>
#include <pthread.h>
#include <stdio.h>
#define loop(n) for (int i = 0; i < n; i++)

#define NR_REP 1000000
//#define NR_REP 1'000'000
int a = 0;

pthread_mutex_t mtx;

void* inc (void* arg)
{
    pthread_mutex_lock(&mtx);

    loop(NR_REP) a++;

    pthread_mutex_unlock(&mtx);

    return NULL;
}

int main()
{
    pthread_mutex_init (&mtx, NULL);

    pthread_t th[2];
    loop(2) pthread_create(&th[i], NULL, inc, NULL);
    loop(2) pthread_join(th[i],NULL);

    pthread_mutex_destroy(&mtx);

    printf("%d\n",a); 
}