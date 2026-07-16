LOCAL_PATH := vendor/zte/fujisan

PRODUCT_SOONG_NAMESPACES += \
    vendor/zte/fujisan

# Keep manifest and compatibility matrix under VINTF packaging control instead
# of copying the raw files into /system/vendor.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# ---- vendor/bin ----
# Include all stock vendor daemons and helpers, EXCLUDING the hw/
# subdirectory whose HAL service binaries are all built from AOSP source.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/bin,$(TARGET_COPY_OUT_VENDOR)/bin)
bin_exclude := $(filter-out \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/bin/hw,$(TARGET_COPY_OUT_VENDOR)/bin/hw))
bin_exclude += \
    $(LOCAL_PATH)/proprietary/vendor/bin/hostapd:$(TARGET_COPY_OUT_VENDOR)/bin/hostapd \
    $(LOCAL_PATH)/proprietary/vendor/bin/ipacm:$(TARGET_COPY_OUT_VENDOR)/bin/ipacm \
    $(LOCAL_PATH)/proprietary/vendor/bin/vndservicemanager:$(TARGET_COPY_OUT_VENDOR)/bin/vndservicemanager
PRODUCT_COPY_FILES := $(filter-out $(bin_exclude),$(PRODUCT_COPY_FILES))

# ---- vendor/etc ----
# Include all stock configuration, excluding init scripts and wifi
# configs (which are handled separately below).
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc,$(TARGET_COPY_OUT_VENDOR)/etc)
PRODUCT_COPY_FILES := $(filter-out \
    %/etc/init/% \
    %/etc/wifi/%, \
    $(PRODUCT_COPY_FILES))

# ---- vendor/etc/init ----
# Include all stock init scripts.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc/init,$(TARGET_COPY_OUT_VENDOR)/etc/init)
# Exclude init scripts for HALs that AOSP builds (which also provide their
# own init scripts) and the problematic stock init/hw scripts.
init_exclude := $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc/init/hw,$(TARGET_COPY_OUT_VENDOR)/etc/init/hw)
init_exclude += \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.camera.provider@2.4-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.camera.provider@2.4-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.cas@1.2-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.cas@1.2-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.configstore@1.1-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.configstore@1.1-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.gatekeeper@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.gatekeeper@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.graphics.allocator@2.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.allocator@2.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.graphics.composer@2.1-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.composer@2.1-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.health@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.health@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.keymaster@3.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.keymaster@3.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.light@2.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.light@2.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.media.omx@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.media.omx@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.memtrack@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.memtrack@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.power@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.power@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.sensors@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.sensors@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.thermal@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.thermal@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.vibrator@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.vibrator@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/android.hardware.wifi@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.wifi@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vendor.display.color@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.display.color@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vendor.dolby.hardware.dms@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.dolby.hardware.dms@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vendor.qti.gnss@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.gnss@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vendor.qti.hardware.qdutils_disp@1.0-service-qti.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.qdutils_disp@1.0-service-qti.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vendor.zte.covolution.assertdisplay.vendorad@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.zte.covolution.assertdisplay.vendorad@1.0-service.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/vndservicemanager.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vndservicemanager.rc
PRODUCT_COPY_FILES := $(filter-out $(init_exclude),$(PRODUCT_COPY_FILES))

# USB composition on msm8996 is device-specific. The generic framework rules
# do not provide the ZTE/Qualcomm product IDs or initialize every function.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/hw/init.msm.usb.configfs.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.msm.usb.configfs.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/hw/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.usb.rc \
    $(LOCAL_PATH)/proprietary/vendor/etc/init/hw/init.vendor.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.vendor.usb.rc

# ---- vendor/etc/wifi ----
# Include all stock wifi configs except the generated wpa_supplicant.conf.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc/wifi,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)
PRODUCT_COPY_FILES := $(filter-out \
    %/etc/wifi/wpa_supplicant.conf, \
    $(PRODUCT_COPY_FILES))
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/etc/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini

# ---- vendor/firmware ----
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/firmware,$(TARGET_COPY_OUT_VENDOR)/firmware)

# ---- vendor/lib ----
# Include all stock 32-bit libraries.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib,$(TARGET_COPY_OUT_VENDOR)/lib)
# AOSP builds all HAL impl libraries from source.
lib_exclude := $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib/hw,$(TARGET_COPY_OUT_VENDOR)/lib/hw)
lib_exclude += \
    $(LOCAL_PATH)/proprietary/vendor/lib/android.hardware.tetheroffload.config@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hardware.tetheroffload.config@1.0.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/libgnsspps.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgnsspps.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/libgps.utils.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgps.utils.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/libgpustats.so:$(TARGET_COPY_OUT_VENDOR)/lib/libgpustats.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/librmnetctl.so:$(TARGET_COPY_OUT_VENDOR)/lib/librmnetctl.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/libsdm-disp-vndapis.so:$(TARGET_COPY_OUT_VENDOR)/lib/libsdm-disp-vndapis.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/vendor.display.color@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.display.color@1.0_vendor.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/vendor.qti.gnss@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.gnss@1.0_vendor.so \
    $(LOCAL_PATH)/proprietary/vendor/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so
PRODUCT_COPY_FILES := $(filter-out $(lib_exclude),$(PRODUCT_COPY_FILES))
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so

# ---- vendor/lib64 ----
# Include all stock 64-bit libraries.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib64,$(TARGET_COPY_OUT_VENDOR)/lib64)
# AOSP builds all HAL impl libraries from source.
lib64_exclude := $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib64/hw,$(TARGET_COPY_OUT_VENDOR)/lib64/hw)
lib64_exclude += \
    $(LOCAL_PATH)/proprietary/vendor/lib64/android.hardware.tetheroffload.config@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/android.hardware.tetheroffload.config@1.0.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/android.hardware.tetheroffload.control@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/android.hardware.tetheroffload.control@1.0.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/libgnsspps.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgnsspps.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/libgps.utils.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgps.utils.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/libgpustats.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgpustats.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/librmnetctl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/librmnetctl.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/libsdm-disp-vndapis.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsdm-disp-vndapis.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/vendor.display.color@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.display.color@1.0_vendor.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/vendor.qti.gnss@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.gnss@1.0_vendor.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so
PRODUCT_COPY_FILES := $(filter-out $(lib64_exclude),$(PRODUCT_COPY_FILES))
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/lib64/hw/gatekeeper.msm8996.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gatekeeper.msm8996.so \
    $(LOCAL_PATH)/proprietary/vendor/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so

# ---- vendor/radio ----
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/radio,$(TARGET_COPY_OUT_VENDOR)/radio)

# ---- system-side stock companions ----
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/system/bin/app6939:$(TARGET_COPY_OUT_SYSTEM)/bin/app6939 \
    $(LOCAL_PATH)/proprietary/system/bin/bt_logger:$(TARGET_COPY_OUT_SYSTEM)/bin/bt_logger \
    $(LOCAL_PATH)/proprietary/system/bin/diag_socket_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/diag_socket_log.sh \
    $(LOCAL_PATH)/proprietary/system/bin/dun-server:$(TARGET_COPY_OUT_SYSTEM)/bin/dun-server \
    $(LOCAL_PATH)/proprietary/system/bin/fgchargerdumper:$(TARGET_COPY_OUT_SYSTEM)/bin/fgchargerdumper \
    $(LOCAL_PATH)/proprietary/system/bin/tloc_daemon:$(TARGET_COPY_OUT_SYSTEM)/bin/tloc_daemon \
    $(LOCAL_PATH)/proprietary/system/bin/usbconfig:$(TARGET_COPY_OUT_SYSTEM)/bin/usbconfig \
    $(LOCAL_PATH)/proprietary/system/etc/permissions/izat.xt.srv.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/izat.xt.srv.xml \
    $(LOCAL_PATH)/proprietary/system/framework/izat.xt.srv.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/izat.xt.srv.jar \
    $(LOCAL_PATH)/proprietary/system/lib/libtrueportrait.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libtrueportrait.so \
    $(LOCAL_PATH)/proprietary/system/lib/vendor.qti.gnss@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib/vendor.qti.gnss@1.0.so \
    $(LOCAL_PATH)/proprietary/system/lib64/libtrueportrait.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libtrueportrait.so \
    $(LOCAL_PATH)/proprietary/system/lib64/libzte_zcore.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libzte_zcore.so \
    $(LOCAL_PATH)/proprietary/system/lib64/vendor.qti.gnss@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.gnss@1.0.so \
    $(LOCAL_PATH)/proprietary/system/lib64/vendor.qti.hardware.wigig.netperftuner@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.hardware.wigig.netperftuner@1.0.so

# Deduplicate in case find-copy-subdir-files produces overlapping entries.
PRODUCT_COPY_FILES := $(sort $(PRODUCT_COPY_FILES))
