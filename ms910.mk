$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/lge/ms910/ms910-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay


# Copy files to target...
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/init.bryce.rc:root/init.bryce.rc 

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)

PRODUCT_PACKAGES += \
    Gallery3d \
    SpareParts \
    Term \
    librs_jni \
    gralloc.msm7x30 \
    overlay.default \
    libOmxCore \
    libOmxVenc \
    libOmxVdec \
    com.android.future.usb.accessory

# Permissions
PRODUCT_COPY_FILES += \
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
PRODUCT_NAME := full_ms910
PRODUCT_DEVICE := ms910

# Kernel modules
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/lib/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/cifs.ko:system/lib/modules/cifs.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/cls_flow.ko:system/lib/modules/cls_flow.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/cpaccess.ko:system/lib/modules/cpaccess.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/dma_test.ko:system/lib/modules/dma_test.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/evbug.ko:system/lib/modules/evobug.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/hdmicec.ko:system/lib/modules/hdmicec.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/hdmitx.ko:system/lib/modules/hdmitx.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/librasdioif.ko:system/lib/modules/librasdioif.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_erasepart.ko:system/lib/modules/mtd_erasepart.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_nandecctest.ko:system/lib/modules/mtd_nandecctest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_oobtest.ko:system/lib/modules/mtd_obbtest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_pagetest.ko:system/lib/modules/mtd_pagetest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_readtest.ko:system/lib/modules/mtd_readtest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_speedtest.ko:system/lib/modules/mtd_speedtest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_stresstest.ko:system/lib/modules/mtd_stresstest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_subpagetest.ko:system/lib/modules/mtd_subpagetest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/mtd_torturetest.ko:system/lib/modules/mtd_torturetest.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/oprofile.ko:system/lib/modules/oprofile.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/qce.ko:system/lib/modules/qce.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/qcedev.ko:system/lib/modules/qcedev.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/qcrypto.ko:system/lib/modules/qcrypo.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/reset_modem.ko:system/lib/modules/reset_modem.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/sch_dsmark.ko:system/lib/modules/sch_dsmark.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/tun.ko:system/lib/modules/tun.ko \
    $(LOCAL_PATH)/prebuilt/lib/modules/wireless.ko:system/lib/modules/wireless.ko

# Keychar & Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keychars/ats_input.kcm.bin:system/usr/keychars/ats_input.kcm.bin \
    $(LOCAL_PATH)/keychars/bryce-keypad.kcm.bin:system/usr/keychars/bryce-keypad.kcm.bin \
    $(LOCAL_PATH)/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    $(LOCAL_PATH)/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    $(LOCAL_PATH)/keychars/touch_keypad.kcm.bin:system/usr/keychars/touch_keypad.kcm.bin \
    $(LOCAL_PATH)/keylayout/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    $(LOCAL_PATH)/keylayout/ats_input.kl:system/usr/keylayout/ats_input.kl \
    $(LOCAL_PATH)/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    $(LOCAL_PATH)/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
    $(LOCAL_PATH)/keylayout/bryce-keypad.kl:system/usr/keylayout/bryce-ketpad.kl \
    $(LOCAL_PATH)/keylayout/msm_tma300_ts.kl:system/usr/keylayout/msm_tma300_ts.kl \
    $(LOCAL_PATH)/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    $(LOCAL_PATH)/keylayout/touch_keypad.kl:system/usr/keylayout/touch_keypad.kl

# HW
PRODUCT_COPY_FILES += \
    vendor/lge/ms910/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \
    vendor/lge/ms910/proprietary/lib/hw/lights.msm7k.so:system/lib/hw/lights.msm7k.so \
    vendor/lge/ms910/proprietary/lib/hw/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so 

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/prebuilt/bin/BCM4329B1_002.002.023.0589.0634.hcd:system/bin/bcm4329.hcd \
    $(LOCAL_PATH)/prebuilt/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    $(LOCAL_PATH)/prebuilt/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw 
 

# SDCard
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab

PRODUCT_PROPERTY_OVERRIDES := \
    debug.sf.hw=0 \
    ro.opengles.version=131072 \
    ro.config.hw_proximity=true \
    ro.telephony.default_network=12 \
    ro.com.google.clientidbase=android-metropcs-us \
    ro.cdma.home.operator.alpha=MetroPCS \
    ro.cdma.home.operator.numeric=310016 \
    ro.config.cdma_subscription=1 \
    ro.cdma.voicemail.number=mine \
    ro.com.google.locationfeatures=1 \
    keyguard.no_require_sim=false \
    ro.sf.lcd_density=240 \
    ro.telephony.ril_class=LGEQualcommUiccRIL \
    ro.telephony.ril.v3=facilitylock,datacall,icccardstatus,singlepdp,qcomuiccstack

