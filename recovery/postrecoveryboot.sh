#!/sbin/sh

# Script by Tyler Montgomery ( http://thecubed.com )

# This script is ran right after recovery is launched.
# also, launch this script if you're stuck in a bootloop!

# Ignore the bootloader's message to wipe data. We dont want to wipe
# every time we launch recovery.
#touch /tmp/.ignorebootmessage
#echo 'version 0.1-pr0' > /tmp/version

# Next, we MUST reset the bootloader command, else we'll be stuck in
# recovery purgatory.

# EDIT: this whole block unnecessary, just here for reference.
# Explanation of command:
# the text "FACT_RESET_" lives at offset 0x1000-0x100B, and offset 0x100C 
# contains a number- "3" for recovery mode, and "6" for normal mode (ASCII)
# in order to escape recovery mode hell, we write "6" to 0x100C.
#busybox echo -ne "\066" | busybox dd bs=1 seek=4107 count=1 conv=notrunc of=/dev/block/mmcblk0p8

# Set performance governor to ondemand
# to ensure system stability...
echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Let emmc settle...
sleep 5

# Zero out boot command
busybox dd if=/dev/zero bs=1 count=84 conv=notrunc of=/dev/block/mmcblk0p8

echo "postrecoveryboot.sh finished"
