# Release name
PRODUCT_RELEASE_NAME := LG Esteem 4G

## Specify phone tech before including full_phone
#$(call inherit-product, vendor/cm/config/cdma.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/ms910/full_ms910.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ms910
PRODUCT_NAME := cm_ms910
PRODUCT_BRAND := MetroPCS
PRODUCT_MODEL := LGMS910
PRODUCT_MANUFACTURER := LGE
PRODUCT_CHARACTERISTICS := phone

CDMA_CARRIER_ALPHA := MetroPCS
CDMA_CARRIER_NUMERIC := 311660

PRODUCT_PROPERTY_OVERRIDES += \
    ro.cdma.home.operator.alpha=$(CDMA_CARRIER_ALPHA) \
    ro.cdma.home.operator.numeric=$(CDMA_CARRIER_NUMERIC)
