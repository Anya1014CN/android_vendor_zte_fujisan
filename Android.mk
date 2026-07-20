LOCAL_PATH := $(call my-dir)

ifneq ($(filter fujisan,$(TARGET_DEVICE)),)
include $(CLEAR_VARS)
LOCAL_MODULE := libsdm-disp-vndapis
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libsdm-disp-vndapis.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libsdm-disp-vndapis.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libgpustats
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libgpustats.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libgpustats.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := fujisan_fingerprint_service
LOCAL_MODULE_OWNER := zte
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := proprietary/vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-service
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_STEM := android.hardware.biometrics.fingerprint@2.1-service
LOCAL_INIT_RC := proprietary/vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc
LOCAL_MULTILIB := 64
LOCAL_PROPRIETARY_MODULE := true
LOCAL_OVERRIDES_MODULES := android.hardware.biometrics.fingerprint@2.1-service
include $(BUILD_PREBUILT)

endif
