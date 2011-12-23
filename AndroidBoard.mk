LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

file := $(TARGET_ROOT_OUT)/init.bryce.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.bryce.rc | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_RECOVERY_ROOT_OUT)/sbin/postrecoveryboot.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/recovery/postrecoveryboot.sh | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)
LOCAL_MODULE := rmt_storage
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := recovery/rmt_storage
include $(BUILD_PREBUILT)

# include the non-open-source counterpart to this file
-include vendor/lge/esteem/AndroidBoardVendor.mk
