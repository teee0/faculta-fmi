/* Creating one child process (v1) */

#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        return errno;
    }
    else if (pid == 0) {
        printf("child, PID=%d (parent=%d)\n", getpid(), getppid());
    }
    else {
        wait(NULL);
        printf("parent, PID=%d\n", getpid());
    }
    return 0;
}

/* Output example:
child, PID = 24422 (parent=24421)
parent, PID = 24421
*/