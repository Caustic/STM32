#!/bin/sh

export ARMPATH=$(pwd)
export ARMBIN=$ARMPATH/gnu-arm-gcc/bin
export PATH=$PATH:$ARMBIN
export OPENCM3_DIR=$ARMPATH/lib/libopencm3
