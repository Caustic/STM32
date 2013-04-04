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
* Install GNU ARM Embedded Toolchain first.

        # Download latest package from https://launchpad.net/gcc-arm-embedded
        # Untar to installation directory and add directory to your path
        export PATH=PATH:$install_dir
        # You're done!

* Install libopencm3 to your toolchain directory
        
        cd ~/stm32/lib/libopencm3
        # Next step requires that the toolhcain is on your $PATH (prev step)
        # May need sudo if you installed GCC-ARM-Embedded to /usr/local
        make DETECT_TOOLCHAIN=1 install

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

