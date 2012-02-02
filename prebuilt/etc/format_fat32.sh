#!/system/bin/sh

### Format EMMC user storage parition : UDB
### this partition is mounted to the /sdcard
### this script is run at the only initial boot

if ls /dev/block/mmcblk0p15 ; then
    mkdir /data/emmc_test
    if mount -t vfat /dev/block/mmcblk0p15 /data/emmc_test ; then
        echo "Already formatting" > /data/emmc_storage.log
        umount /data/emmc_test
    else
        echo "FAT32 partition initialization Now..." > /data/emmc_storage.log
        echo "Formating /dev/block/mmcblk0p15 as FAT32, Label INTERNAL" >> /data/emmc_storage.log
        /system/bin/newfs_msdos -F 32 -O android -c 32 -L INTERNAL /dev/block/mmcblk0p15
    fi
    rmdir /data/emmc_test
else
    if ls /dev/block/mmcblk1p15 ; then
        mkdir /data/emmc_test
        if mount -t vfat /dev/block/mmcblk1p15 /data/emmc_test ; then
            echo "Already formatting" > /data/emmc_storage.log
            umount /data/emmc_test
        else
            echo "FAT32 partition initialization Now..." > /data/emmc_storage.log
            echo "Formating /dev/block/mmcblk1p15 as FAT32, Label INTERNAL" >> /data/emmc_storage.log
            /system/bin/newfs_msdos -F 32 -O android -c 32 -L INTERNAL /dev/block/mmcblk1p15
        fi
        rmdir /data/emmc_test
    fi
fi
