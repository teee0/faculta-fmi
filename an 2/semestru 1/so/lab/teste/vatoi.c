#include <stdio.h>
#include <stdlib.h>

int main()
{
    char* a = "1232";
    void* b = (void*) a;
    int c = atoi (a);
    printf("%d",c);
}