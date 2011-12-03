USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/lge/esteem/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true

## ARMv7 Processor rev 2 (v7l)
TARGET_BOARD_PLATFORM := msm7x30
TARGET_CPU_ABI := armeabi
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOOTLOADER_BOARD_NAME := esteem
ARCH_ARM_HAVE_TLS_REGISTER := true


BOARD_KERNEL_CMDLINE := console=ttyMSM1 androidboot.hardware=bryce
BOARD_KERNEL_BASE := 0x00200000
BOARD_PAGE_SIZE := 0x00000800

## Partition sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00800000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00800000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x08c60000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_SDCARD_DEVICE_PRIMARY := /dev/block/mmcblk1p1
BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/mmcblk1

BOARD_HAS_NO_MISC_PARTITON := true

TARGET_USERIMAGES_USE_EXT4 := true
USE_EXT4 := true
BOARD_HAS_SDCARD_INTERNAL := true

# custom lun0 file for USB Mass Storage
BOARD_UMS_LUNFILE := /sys/devices/platform/msm_hsusb/gadget/lun2/file

TARGET_PREBUILT_KERNEL := device/lge/esteem/kernel

BOARD_CUSTOM_GRAPHICS := ../../../device/lge/esteem/recovery/graphics.c

BOARD_HAS_NO_SELECT_BUTTON := true

# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true