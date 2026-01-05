#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
int main(int argc, char** argv)
{
    pid_t pid_copil = fork();
    if (pid_copil < 0) return -1;
    char* x = argv[1];
    int y;

    if(pid_copil==0) //executat de copil
    {
        //printf("%s\n",x);
        y = atoi(x);
        printf("%d ", y);
        wait (NULL);
        while(y>1)
        {
            if(y%2==0)y/=2;
            else y=y*3+1;
            printf("%d ",y);
            
        }
        printf("\n");
    }

    return 0;
}