#include "mystrlen.h"
int mystrlen(char *string)
{
    int i;
    i = 0;
    while(*string){
        i = i + 1;
        string = string + 1;
    }
    return i;
}
