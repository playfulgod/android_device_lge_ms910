## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := Esteem-ICS

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/esteem/full_esteem.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := esteem
PRODUCT_NAME := cm_esteem
PRODUCT_BRAND := MetroPCS
PRODUCT_MODEL := LG-MS910

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_DEVICE=bryce PRODUCT_NAME=bryce BUILD_ID=LG-MS910-ICS BUILD_DISPLAY_ID=LG-MS910-ICS BUILD_FINGERPRINT="MetroPCS/lge_bryce/MS910:4.0.3/ICS/ZVB.422A0D75:user/release-keys" PRIVATE_BUILD_DESC="lge_bryce-user 4.0.3 ICS release-keys"
