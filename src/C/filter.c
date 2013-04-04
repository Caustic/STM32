#include "filter.h"
#include <libopencm3/cm3/common.h>

s32 lowpass(s32 input, s32 old)
{
    return input - ((LPCO * input)  >> 10) + ((LPCO * old)  >> 10);
}

/*
s32 highpass(s32 input, s32 old)
{
    return (((HPCO * input) >> 10) - input) - ((HPCO * old) >> 10);
}
*/

s32 highpass(s32 input, s32 inputd, s32 old)
{
    return (HPCO * ( old + input - inputd )) >> 10;
}
