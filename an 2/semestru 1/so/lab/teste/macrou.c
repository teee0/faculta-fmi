#include <stdio.h>
#include <pthread.h>
#include <stdio.h>
#define loop(n) for (int i = 0; i < n; i++)

#define mtx_init(m, body)         \
do {                               \
    pthread_mutex_init (&m, NULL); \
    body                           \
    pthread_mutex_destroy(&m);     \
}while (0)                         

#define mtx_block(m, body)   \
do{                          \
    pthread_mutex_lock(&m);  \
    body                     \
    pthread_mutex_unlock(&m);\
} while (0)                  

#define NR_REP 1000000
//#define NR_REP 1'000'000
int a = 0;

pthread_mutex_t mtx;
void* inc (void* arg)
{
    mtx_block(
        mtx,
        loop(NR_REP) a++;
    );
    return NULL;
}

int main()
{
    mtx_init(
        mtx,
    {
        pthread_t th[2];
        loop(2) pthread_create(&th[i], NULL, inc, NULL);
        loop(2) pthread_join(th[i],NULL);
    });
    printf("%d\n",a); 
}