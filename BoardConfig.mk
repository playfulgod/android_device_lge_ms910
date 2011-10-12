USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/lge/esteem/BoardConfigVendor.mk

## ARMv7 Processor rev 2 (v7l)
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := msm8k


TARGET_CPU_ABI := armeabi
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOOTLOADER_BOARD_NAME := esteem

BOARD_KERNEL_CMDLINE := console=ttyMSM1 androidboot.hardware=qcom
BOARD_KERNEL_BASE := 0x00200000
BOARD_KERNEL_PAGESIZE := 4096

## Partition sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1031798784
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1572864
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_PREBUILT_KERNEL := device/lge/esteem/kernel

#BOARD_HAS_NO_SELECT_BUTTON := true
# Use this flag if the board has a ext4 partition larger than 2gb
#BOARD_HAS_LARGE_FILESYSTEM := true