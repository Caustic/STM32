/*
 * This file is part of the libopencm3 project.
 *
 * Copyright (C) 2009 Uwe Hermann <uwe@hermann-uwe.de>
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <libopencm3/stm32/f1/rcc.h>
#include <libopencm3/stm32/f1/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/f1/adc.h>
#include <libopencm3/stm32/f1/dac.h>
#include <libopencm3/stm32/f1/timer.h>
#include <libopencm3/stm32/f1/nvic.h>
#include <libopencm3/cm3/common.h>
#include "str.h"
#include "lcd.h"
#include "filter.h"

static volatile u16 adc_val;
static volatile u16 adc_vald;

static void clock_setup(void)
{
    rcc_clock_setup_in_hse_8mhz_out_24mhz();
    rcc_peripheral_enable_clock(&RCC_APB2ENR, RCC_APB2ENR_IOPAEN);
    rcc_peripheral_enable_clock(&RCC_APB2ENR, RCC_APB2ENR_IOPCEN);
    rcc_peripheral_enable_clock(&RCC_APB2ENR, RCC_APB2ENR_USART1EN);
	rcc_peripheral_enable_clock(&RCC_APB2ENR, RCC_APB2ENR_ADC1EN);
	rcc_peripheral_enable_clock(&RCC_APB1ENR, RCC_APB1ENR_DACEN);
	rcc_peripheral_enable_clock(&RCC_APB1ENR, RCC_APB1ENR_TIM3EN);
}

static void usart_setup(void)
{
    /* Setup GPIO pin GPIO_USART1_TX/GPIO9 on GPIO port A for transmit. */
    gpio_set_mode(GPIOA, GPIO_MODE_OUTPUT_50_MHZ,
            GPIO_CNF_OUTPUT_ALTFN_PUSHPULL, GPIO_USART1_TX);
    /* Setup UART parameters. */
    /* Set Buadrate */
    /* 24MHz / 9600Hz */
    USART_BRR(USART1) = 0x9c4;
    /* usart_set_baudrate(USART_CONSOLE, 9600); */
    usart_set_databits(USART1, 8);
    usart_set_stopbits(USART1, USART_STOPBITS_1);
    usart_set_mode(USART1, USART_MODE_TX);
    usart_set_parity(USART1, USART_PARITY_NONE);
    usart_set_flow_control(USART1, USART_FLOWCONTROL_NONE);
    usart_enable(USART1);
}

static void gpio_setup(void)
{
    /* Set GPIO9 (in GPIO port C) to 'output push-pull'. [LED] */
    gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ,
            GPIO_CNF_OUTPUT_PUSHPULL, GPIO9);
}

static void adc_setup(void)
{
    /* ADC1 port A0 */
	gpio_set_mode(GPIOA, GPIO_MODE_INPUT, GPIO_CNF_INPUT_ANALOG, GPIO0);
	/* Make sure the ADC doesn't run during config. */
	adc_off(ADC1);
	/* We configure everything for one single conversion. */
	adc_disable_scan_mode(ADC1);
	adc_disable_external_trigger_regular(ADC1);
	adc_set_right_aligned(ADC1);
	adc_set_continuous_conversion_mode(ADC1);
	adc_set_sample_time_on_all_channels(ADC1, ADC_SMPR_SMP_28DOT5CYC);
	adc_power_on(ADC1);
	int i;
	for (i = 0; i < 800000; i++) /* Wait a bit. */
		__asm__("nop");
	adc_reset_calibration(ADC1);
	adc_calibration(ADC1);
    adc_start_conversion_direct(ADC1);
}

static void dac_setup(void)
{
    gpio_set_mode(GPIOA, GPIO_MODE_OUTPUT_50_MHZ, GPIO_CNF_OUTPUT_ALTFN_PUSHPULL, GPIO4);
    gpio_set_mode(GPIOA, GPIO_MODE_OUTPUT_50_MHZ, GPIO_CNF_OUTPUT_ALTFN_PUSHPULL, GPIO5);
    dac_disable(CHANNEL_1);
    dac_disable(CHANNEL_2);
    dac_dma_disable(CHANNEL_1);
    dac_dma_disable(CHANNEL_2);
    dac_trigger_disable(CHANNEL_1);
    dac_trigger_disable(CHANNEL_2);
    /*
    dac_set_trigger_source(DAC_CR_TSEL1_SW);
    dac_set_trigger_source(DAC_CR_TSEL2_SW);
    */
    dac_disable_waveform_generation(CHANNEL_1);
    dac_disable_waveform_generation(CHANNEL_2);
    dac_enable(CHANNEL_1);
    dac_enable(CHANNEL_2);
    /*
    dac_trigger_enable(CHANNEL_2);
    */
}

static void tim3_setup(void)
{
    timer_reset(TIM3);
    timer_set_prescaler(TIM3, 544);
    timer_set_period(TIM3, 1);
    nvic_enable_irq(NVIC_TIM3_IRQ);
	timer_enable_update_event(TIM3); // default at reset!
    /* Set DMA/Interrupt Enable Register Update Interrupt Enable flag */
	timer_enable_irq(TIM3, TIM_DIER_UIE);
    /* Enable Counter */
	timer_enable_counter(TIM3);
}

void tim3_isr(void)
{
	TIM_SR(TIM3) &= ~TIM_SR_UIF;
    gpio_toggle(GPIOC, GPIO9);	/* LED on/off */
    while(!adc_eoc(ADC1)); /* This shouldn't be a problem, ADC set to continuous */
    adc_vald = adc_val;
    adc_val = adc_read_regular(ADC1);
}

int main(void)
{
    int i;
    char buffer[256];
    s32 hpd, lpd, av, avd;
    /* This is Space Invaders */
    /* [ctrl byte, char to change, bmp string] */
    unsigned char *mkch0 = "\x19\x00\x04\x03\x07\x0d\x1F\x17\x14\x03"
                           "\x19\x01\x04\x38\x3c\x36\x3f\x3d\x05\x1c";
    clock_setup();
    gpio_setup();
    usart_setup();
	adc_setup();
	dac_setup();
    tim3_setup();
    clearlcd();

    hpd = 0;
    lpd = 0;
    /* Configure Space Invaders Characters */
    for(i = 0; i < 20; i++)
        usart_send_blocking(USART1, *(mkch0+i));
    clearlcd();
    /* Show Space Invaders Character */
    for(i = 0; i < 16; i++)
        printlcd("\x80\x81");
    while (1) {
        av = adc_val - 2048;
        avd = adc_vald - 2048;
        lpd = lowpass(av, lpd);
        hpd = highpass(av, avd, hpd);
        dac_load_data_buffer_dual(lpd+2048, (hpd+2048), RIGHT12);
    }
    return 0;
}

