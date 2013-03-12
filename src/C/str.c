#include "str.h"
int strlen(char string[])
{
    int i;
    i = 0;
    while(*string){
        i = i + 1;
        string = string + 1;
    }
    return i;
}
void itoa(int n, char string[])
{
    int i;
    i = 0;
    do {       /* generate digits in reverse order */
        string[i++] = n % 10 + '0';   /* get next digit */
    } while ((n /= 10) > 0);     /* delete it */
    string[i] = '\0';
    reverse(string);
}
void reverse(char string[])
{
    int i, j;
    char c;
    for (i = 0, j = strlen(string)-1; i<j; i++, j--) {
        c = string[i];
        string[i] = string[j];
        string[j] = c;
    }
}
