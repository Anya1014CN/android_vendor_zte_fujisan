LOCAL_PATH := $(call my-dir)

ifneq ($(filter fujisan,$(TARGET_DEVICE)),)
include $(CLEAR_VARS)
LOCAL_MODULE := libgps.utils
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libgps.utils.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libgps.utils.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libgnsspps
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libgnsspps.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libgnsspps.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libloc_core
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libloc_core.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libloc_core.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

# The ZTE Oreo GNSS service dynamically loads this bridge together with
# liblocation_api.  Use the factory pair so the LocationCallbacks/SV ABI
# matches the OEM libloc_core runtime.
include $(CLEAR_VARS)
LOCAL_MODULE := liblocation_api
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/liblocation_api.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/liblocation_api.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libgnss
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/libgnss.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/libgnss.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.gnss@1.0-impl-qti
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/hw/android.hardware.gnss@1.0-impl-qti.so
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/hw/android.hardware.gnss@1.0-impl-qti.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
include $(BUILD_PREBUILT)

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

include $(CLEAR_VARS)
LOCAL_MODULE := libfujisan_graphicbuffer_compat
LOCAL_MODULE_OWNER := zte
LOCAL_SRC_FILES := proprietary/vendor/lib/libfujisan_graphicbuffer_compat.so
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MULTILIB := 32
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

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


endif
