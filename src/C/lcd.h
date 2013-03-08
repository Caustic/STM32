#ifndef LCD_H
#define LCD_H

#define LCD_LF '\x0C'
#define LCD_HOME '\001'

void printlcd(char *message);
void clearlcd(void);

#endif
