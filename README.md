STM32 Development
=================

This repository provides all the means for setting up the STM32 development environment in linux for the STM32L-Discovery and STM32VL-Discovery boards.


How to get Started
------------------

* Fork/Clone/Download the repository.

        git clone git://github.com/Caustic/stm32.git ~/stm32
        cd stm32
        git submodule init
        git submodule update

* __NOTE__: You can install GNU ARM Embedded Toolchain instead of Summon Arm Toolchain, just make sure its on your path!
* Install Summon Arm Toolchain First

        git clone git://github.com/esden/summon-arm-toolchain.git
        cd summon-arm-toolchain
        # There are some options that you can set before running this so check the readme if you want.
        ./summon-arm-toolchain
        # Make sure that `$SAR/arm/bin` is on your path where $SAR is the path Summon Arm Toolchain was installed
        # In env.sh, there is a variable that you can set to point to this path

* Install STLink next

        cd ~/stm32/stlink
        ./autogen.sh
        ./configure
        make

* If you have STLink V1 (STM32VL)

        sudo cp ./stlink_v1.modprobe.conf /etc/modprobe.d/
        sudo modprobe -r usb-storage && modprobe usb-storage
        sudo cp ./49-stlinkv1.rules /etc/udev/rules.d/
        sudo udevadm control --reload-rules

* If you have STLink V2

        sudo cp ./49-stlinkv1.rules /etc/udev/rules.d/
        sudo udevadm control --reload-rules

* Plug in your STM32L Board.

* Start the STLink local server from the stlink repository.

        ~/stm32/stlink/st-util

* Flash the rom and run your (compiled) program!:

        arm-none-eabi-gdb program.elf
        (gdb) tar ex :4242
        (gdb) load
        (gdb) c


Some Useful Links
-----------------

[OpenOCD](http://openocd.sourceforge.net/)

[STLink for Linux](https://github.com/texane/stlink)

[SAR toolchain for Linux](https://github.com/esden/summon-arm-toolchain)

[Cortex M3 Open Library](https://github.com/libopencm3/libopencm3)

