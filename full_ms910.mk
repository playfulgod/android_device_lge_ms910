# Get the long list of APNs
PRODUCT_COPY_FILES := device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml

# Camera
PRODUCT_PACKAGES := \
    Camera 


# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)
# Inherit from maguro device
$(call inherit-product, device/lge/ms910/ms910.mk)

# Set those variables here to overwrite the inherited values.
PRODUCT_NAME := full_ms910
PRODUCT_DEVICE := ms910
PRODUCT_BRAND := MetroPCS
PRODUCT_MODEL := LG-MS910

