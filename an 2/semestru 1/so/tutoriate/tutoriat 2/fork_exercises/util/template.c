#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>

void pr ()
{
  printf("pid :%d ppid:%d\n",getpid(),getppid());
}

void clear_log() {
    FILE *log_file = fopen("forks.log", "w");
    if (log_file != NULL) {
        fclose(log_file);
    }
}

void log_fork(pid_t parent, pid_t child) {
    FILE *log_file = fopen("forks.log", "a");
    if (log_file != NULL) {
        fprintf(log_file, "Parent %d Me %d\n", parent, child);
        fclose(log_file);
        }
}

int main() {
    clear_log();

pr();
 
  if (fork() == 0)
  {
    pr();
    for (int i=3; i<=7; i++)
    {
        if(fork()==0) {
          pr();
          
          if(i==3 || i==7)
          {
            if(fork()==0)
            {
              pr();
              if(fork()==0){
                pr();
                exit(0);
              } 
              else wait(0);
              exit(0);
            }
            else wait(0);
          } 
          else wait(0);
          exit(0);
        }
        wait(0);
    }//endfor
    exit(0);
  } 
  wait(0);
    log_fork(getppid(), getpid());
    sleep(10);
    wait(NULL);

    return 0;
}
