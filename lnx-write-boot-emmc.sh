#!/bin/bash

if [ -z "$1" ]; then
	wdir=`pwd`/deploy
else
	wdir=$1
fi

if [ -d ${wdir} ] ; then
	set -x
	mmc bootpart enable 1 2 /dev/mmcblk0
	mmc bootbus set single_backward x1 x8 /dev/mmcblk0
	mmc hwreset enable /dev/mmcblk0
	set -e
	echo '0' >> /sys/class/block/mmcblk0boot0/force_ro

	# Nuke the contents of emmc boot0 first
	echo "dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k"
	dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k

	# Put the tiboot3.bin in mmcblk0boot0
	dd if=${wdir}/tiboot3.bin of=/dev/mmcblk0boot0 bs=128k

	# Now the rest of the images in the UDA boot partition
	boot_partition=`mktemp -d`
	mount /dev/mmcblk0p1 ${boot_partition}
	cp -v ${wdir}/tispl.bin \
		${wdir}/u-boot.img \
		${wdir}/sysfw.itb \
		${boot_partition}
	umount ${boot_partition}
	sync
	sync
	rm -rvf ${boot_partition}
fi
