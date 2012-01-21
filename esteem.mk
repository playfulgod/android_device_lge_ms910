$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/lge/esteem/esteem-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/lge/esteem/overlay

# Init files
PRODUCT_COPY_FILES += \
      device/lge/esteem/init.bryce.rc:root/init.bryce.rc 

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/lge/esteem/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

PRODUCT_PACKAGES += \
    Gallery3d \
    SpareParts \
    Term \
    gps.triumph \
    librs_jni \
    gralloc.msm7x30 \
    overlay.default \
    hwcomposer.default \
    hwcomposer.msm7x30 \
    overlay.default \
    libgenlock \
    libOmxCore \
    libOmxVenc \
    libOmxVdec \
    liboverlay \
    com.android.future.usb.accessory

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# use high-density artwork where available
PRODUCT_LOCALES += hdpi

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_esteem
PRODUCT_DEVICE := esteem

PRODUCT_DEFAULT_LANGUAGE := en_US
PRODUCT_DEFAULT_REGION := US

# Kernel modules
PRODUCT_COPY_FILES += \
    vendor/lge/esteem/proprietary/lib/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    vendor/lge/esteem/proprietary/lib/modules/cifs.ko:system/lib/modules/cifs.ko \
    vendor/lge/esteem/proprietary/lib/modules/cls_flow.ko:system/lib/modules/cls_flow.ko \
    vendor/lge/esteem/proprietary/lib/modules/cpaccess.ko:system/lib/modules/cpaccess.ko \
    vendor/lge/esteem/proprietary/lib/modules/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    vendor/lge/esteem/proprietary/lib/modules/dma_test.ko:system/lib/modules/dma_test.ko \
    device/lge/esteem/include/lib/modules/evbug.ko:system/lib/modules/evobug.ko \
    vendor/lge/esteem/proprietary/lib/modules/hdmicec.ko:system/lib/modules/hdmicec.ko \
    vendor/lge/esteem/proprietary/lib/modules/hdmitx.ko:system/lib/modules/hdmitx.ko \
    vendor/lge/esteem/proprietary/lib/modules/librasdioif.ko:system/lib/modules/librasdioif.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_erasepart.ko:system/lib/modules/mtd_erasepart.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_nandecctest.ko:system/lib/modules/mtd_nandecctest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_oobtest.ko:system/lib/modules/mtd_obbtest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_pagetest.ko:system/lib/modules/mtd_pagetest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_readtest.ko:system/lib/modules/mtd_readtest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_speedtest.ko:system/lib/modules/mtd_speedtest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_stresstest.ko:system/lib/modules/mtd_stresstest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_subpagetest.ko:system/lib/modules/mtd_subpagetest.ko \
    vendor/lge/esteem/proprietary/lib/modules/mtd_torturetest.ko:system/lib/modules/mtd_torturetest.ko \
    vendor/lge/esteem/proprietary/lib/modules/oprofile.ko:system/lib/modules/oprofile.ko \
    vendor/lge/esteem/proprietary/lib/modules/qce.ko:system/lib/modules/qce.ko \
    vendor/lge/esteem/proprietary/lib/modules/qcedev.ko:system/lib/modules/qcedev.ko \
    vendor/lge/esteem/proprietary/lib/modules/qcrypto.ko:system/lib/modules/qcrypo.ko \
    vendor/lge/esteem/proprietary/lib/modules/reset_modem.ko:system/lib/modules/reset_modem.ko \
    vendor/lge/esteem/proprietary/lib/modules/sch_dsmark.ko:system/lib/modules/sch_dsmark.ko \
    device/lge/esteem/include/lib/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    vendor/lge/esteem/proprietary/lib/modules/tun.ko:system/lib/modules/tun.ko \
    device/lge/esteem/include/lib/modules/wireless.ko:system/lib/modules/wireless.ko

# HW
PRODUCT_COPY_FILES += \
    vendor/lge/esteem/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \
    vendor/lge/esteem/proprietary/lib/hw/lights.msm7k.so:system/lib/hw/lights.msm7k.so 
#    vendor/lge/esteem/proprietary/lib/hw/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so 

PRODUCT_COPY_FILES += \
    vendor/lge/esteem/proprietary/etc/gps.conf:system/etc/gps.conf \
    vendor/lge/esteem/proprietary/bin/BCM4329B1_002.002.023.0589.0634.hcd:system/bin/bcm4329.hcd \
    vendor/lge/esteem/proprietary/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    vendor/lge/esteem/proprietary/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \
#    vendor/lge/esteem/proprietary/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
#    vendor/lge/esteem/proprietary/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
#    vendor/lge/esteem/proprietary/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
#    vendor/lge/esteem/proprietary/lib/libGLESv1_CM.so:system/lib/libGLESv1_CM.so \
#    vendor/lge/esteem/proprietary/lib/libGLESv2.so:system/lib/libGLESv2.so \

# SDCard
PRODUCT_COPY_FILES += \
    device/lge/esteem/vold.fstab:system/etc/vol.fstab

PRODUCT_COPY_FILES += \
    device/lge/esteem/include/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    device/lge/esteem/keychars/ats_input.kcm.bin:system/usr/keychars/ats_input.kcm.bin \
    device/lge/esteem/keychars/bryce-keypad.kcm.bin:system/usr/keychars/bryce-keypad.kcm.bin \
    device/lge/esteem/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/lge/esteem/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/lge/esteem/keychars/touch_keypad.kcm.bin:system/usr/keychars/touch_keypad.kcm.bin \
    device/lge/esteem/keylayout/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    device/lge/esteem/keylayout/ats_input.kl:system/usr/keylayout/ats_input.kl \
    device/lge/esteem/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/lge/esteem/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
    device/lge/esteem/keylayout/bryce-keypad.kl:system/usr/keylayout/bryce-ketpad.kl \
    device/lge/esteem/keylayout/msm_tma300_ts.kl:system/usr/keylayout/msm_tma300_ts.kl \
    device/lge/esteem/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/lge/esteem/keylayout/touch_keypad.kl:system/usr/keylayout/touch_keypad.kl

#PRODUCT_COPY_FILES += \
#    device/lge/esteem/include/lib/libgsl.so:system/lib/libgsl.so
