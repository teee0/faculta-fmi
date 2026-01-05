#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
int main()
{
    pid_t pid_copil = fork();
    if (pid_copil < 0) return -1;
    
    if(pid_copil==0) //executat de copil
    {
        char* argv[] = {"ls", NULL};
        execve("/bin/ls", argv, NULL);
        
    }

    if (pid_copil > 0)
    {
        printf("PID Părinte: %i\nPID Copil: %i\n", getpid(), pid_copil);
        wait (NULL);
    }
    return 0;
}