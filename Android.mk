LOCAL_PATH := $(call my-dir)

ifneq ($(filter fujisan,$(TARGET_DEVICE)),)
ifeq ($(TARGET_USES_FUJISAN_SOURCE_QCAMERA),false)
include $(CLEAR_VARS)
LOCAL_MODULE := camera.msm8996
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES := proprietary/vendor/lib/hw/camera.msm8996.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_STEM := camera.msm8996
LOCAL_MULTILIB := 32
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := libmmcamera_interface
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES := proprietary/vendor/lib/libmmcamera_interface.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := 32
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

ifeq ($(TARGET_USES_FUJISAN_SOURCE_QCAMERA),true)
include $(CLEAR_VARS)
LOCAL_MODULE := libmmjpeg_interface
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES := proprietary/vendor/lib/libmmjpeg_interface.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := 32
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)
endif

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
# libgsl and libCB are supplied by the device vendor image but are not
# registered as build modules. Keep the prebuilt's existing vendor ABI.
LOCAL_CHECK_ELF_FILES := false
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libc2d30-a5xx
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libc2d30-a5xx.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libc2d30-a5xx.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
# GPU C2D backend paired with the existing device libC2D2.so.
LOCAL_CHECK_ELF_FILES := false
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libc2d30_bltlib
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libc2d30_bltlib.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libc2d30_bltlib.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
# GPU C2D backend paired with the existing device libC2D2.so.
LOCAL_CHECK_ELF_FILES := false
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := fujisan_fingerprint_blob_overlay
LOCAL_MODULE_OWNER := zte
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := proprietary/vendor/etc/init/fujisan.fingerprint.rc
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/etc
LOCAL_MODULE_STEM := .fujisan_fingerprint_blob_overlay
LOCAL_REQUIRED_MODULES := android.hardware.biometrics.fingerprint@2.1-service
LOCAL_POST_INSTALL_CMD := cp $(LOCAL_PATH)/proprietary/vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-service $(TARGET_OUT_VENDOR)/bin/hw/android.hardware.biometrics.fingerprint@2.1-service && chmod 755 $(TARGET_OUT_VENDOR)/bin/hw/android.hardware.biometrics.fingerprint@2.1-service
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

endif
