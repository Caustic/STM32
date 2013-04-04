#ifndef FILTER_H
#define FILTER_H
#include <libopencm3/cm3/common.h>

/* LPCO / 1024 */
#define LPCO 985
/* HPCO / 1024 */
#define HPCO 800

s32 lowpass(s32 input, s32 old);
s32 highpass(s32 input, s32 inputd, s32 old);

#endif
