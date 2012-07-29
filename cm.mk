## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/cdma.mk)

TARGET_BOOTANIMATION_NAME :=

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/ms910/ms910.mk)

PRODUCT_NAME := cm_ms910

# Release name and versioning
PRODUCT_RELEASE_NAME := LG Esteem 4G
PRODUCT_VERSION_DEVICE_SPECIFIC :=

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ms910

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_DEVICE=MS910 PRODUCT_NAME=lge_bryce BUILD_ID=LG-MS910-CM9 BUILD_DISPLAY_ID=LG-MS910-ICS BUILD_FINGERPRINT="MetroPCS/lge_bryce/MS910:2.3.4/GINGERBREAD/ZVD.47A8C0B1:user/release-keys" PRIVATE_BUILD_DESC="lge_bryce-user 2.3.4 GINGERBREAD ZVD.47A8C0B1 release-keys"

# Enable Torch
PRODUCT_PACKAGES += Torch
