#include <libopencm3/stm32/f1/rcc.h>
#include <libopencm3/stm32/f1/gpio.h>
#include <libopencm3/stm32/usart.h>
#include "lcd.h"
#include "mystrlen.h"

void printlcd(char *message)
{
    int len, i;
    len = mystrlen(message);
    for (i=0; i<len; i++){
        usart_send_blocking(USART1, message[i]); /* USART1: Send byte. */
    }
}
