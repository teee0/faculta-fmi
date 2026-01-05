#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void* inverseaza(void* str)
{
    char* sir=(char*)str;

    char* rez=(char*)malloc(strlen(sir)+1);
    for (int i=strlen(sir)-1; i>=0; i--)
    {
        rez[strlen(sir)-1-i]=sir[i];
    }
    rez[strlen(sir)]='\0';
    
    return (void*)rez;
}

int main(int nr_arg, char** v_arg)
{
    char* str=v_arg[1];

    pthread_t thread;
    pthread_create(&thread, NULL, inverseaza, str);

    void* rez;
    pthread_join(thread, &rez);
    char* rezultat=(char*)rez;

    puts(rezultat);
    return 0;
}