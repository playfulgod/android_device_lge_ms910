# Custom apns must come before cdma.mk is included
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/cdma.mk)

# Boot animation
TARGET_BOOTANIMATION_NAME := vertical-480x800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/ms910/full_ms910.mk)

# Release name
PRODUCT_RELEASE_NAME := LG Esteem 4G

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ms910
PRODUCT_NAME := cm_ms910
PRODUCT_BRAND := MetroPCS
PRODUCT_MODEL := LGMS910
PRODUCT_MANUFACTURER := LGE

CDMA_CARRIER_ALPHA := MetroPCS
CDMA_CARRIER_NUMERIC := 311660

PRODUCT_PROPERTY_OVERRIDES += \
	ro.carrier=$(CDMA_CARRIER_ALPHA) \
    ro.cdma.home.operator.alpha=$(CDMA_CARRIER_ALPHA) \
    ro.cdma.home.operator.numeric=$(CDMA_CARRIER_NUMERIC) \
	ro.com.google.clientidbase=android-lge \
	ro.com.google.clientidbase.ms=android-metropcs-us \
	ro.com.google.clientidbase.gmm=android-lge \
	ro.com.google.clientidbase.yt=android-lge \
	ro.com.google.clientidbase.am=android-lge
