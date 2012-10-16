# Release name
PRODUCT_RELEASE_NAME := LG Esteem 4G

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/cdma.mk)

TARGET_BOOTANIMATION_NAME := vertical-480x800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/ms910/ms910.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ms910
PRODUCT_NAME := cm_ms910
PRODUCT_BRAND := MetroPCS
PRODUCT_MODEL := LGMS910
PRODUCT_MANUFACTURER := LGE
PRODUCT_CHARACTERISTICS := phone

