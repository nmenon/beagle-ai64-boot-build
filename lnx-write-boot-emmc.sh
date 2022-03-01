#!/bin/bash

wdir=/boot/firmware/
if [ -d ${wdir} ] ; then
	set -x
	mmc bootpart enable 1 2 /dev/mmcblk0
	mmc bootbus set single_backward x1 x8 /dev/mmcblk0
	mmc hwreset enable /dev/mmcblk0
	set -e
	echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
	dd if=${wdir}/tiboot3.bin of=/dev/mmcblk0boot0 count=3 bs=128k
	dd if=${wdir}/tispl.bin of=/dev/mmcblk0boot0 seek=3 count=6 bs=128k
	dd if=${wdir}/u-boot.img of=/dev/mmcblk0boot0 seek=9 count=16 bs=128k
	dd if=${wdir}/sysfw.itb of=/dev/mmcblk0boot0 seek=25 count=3 bs=128k
fi
