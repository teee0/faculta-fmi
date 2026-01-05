#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
int main(int argc, char** argv)
{
    pid_t pid_copil = fork();
    if (pid_copil < 0) return -1;
    char* x;
    int y;

    for (int i = 0; i < argc-1; ++i) {
        pid_t pid = fork();

        if (pid < 0) return -1;
        else if (pid == 0) {
            //printf("child %d, PID=%d\n", i, getpid());


            exit(0);
        }

    }



    if(pid_copil==0) //executat de copil
    {
        for (int i = 0; i < argc-1; ++i) 
        {
            x = argv[1+i];
            y = atoi(x);

            printf("%d ",y);
            while(y>1)
            {
                if(y%2==0)y/=2;
                else y=y*3+1;
                printf("%d ",y);
                
            }
            printf("\n");
        wait(NULL);
    }
    }

    return 0;
}