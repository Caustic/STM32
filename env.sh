#!/bin/sh

export ARMPATH=$(pwd)
export ARMBIN=$ARMPATH/arm/bin
export PATH=$PATH:$ARMBIN
export TOOLCHAIN_DIR=$ARMPATH/lib/libopencm3
