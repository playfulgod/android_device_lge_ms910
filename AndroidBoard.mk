LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

file := $(TARGET_RECOVERY_ROOT_OUT)/sbin/postrecoveryboot.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/postrecoveryboot.sh | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.bryce.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.bryce.rc | $(ACP)
	$(transform-prebuilt-to-target)

# include the non-open-source counterpart to this file
-include vendor/lge/esteem/AndroidBoardVendor.mk
