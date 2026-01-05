#include <pthread.h>
#include <stdio.h>
#define loop(n) for (int i = 0; i < n; i++)

#define NR_REP 1000000
//#define NR_REP 1'000'000
int a = 0;

void* inc (void* arg)
{
    //(*((int*)(arg)))++; // am vrut sa vad daca merge 
    loop(NR_REP) a++;

    return NULL;
}

int main()
{
    pthread_t th[2];
    loop(2) pthread_create(&th[i], NULL, inc, NULL);
    loop(2) pthread_join(th[i],NULL);
    printf("%d\n",a); 
}