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

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=lge_bryce BUILD_ID=LG-MS910-CM9 BUILD_DISPLAY_ID=LG-MS910-IMM76L BUILD_FINGERPRINT="MetroPCS/lge_bryce/MS910:4.0.4/IMM76L/MS910ZVD.422A0D75:user/release-keys" PRIVATE_BUILD_DESC="lge_bryce-user 4.0.4 IMM76L release-keys"

# Enable Torch
PRODUCT_PACKAGES += Torch
