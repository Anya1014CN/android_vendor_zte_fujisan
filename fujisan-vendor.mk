LOCAL_PATH := vendor/zte/fujisan

PRODUCT_SOONG_NAMESPACES += \
    vendor/zte/fujisan

# Keep manifest and compatibility matrix under VINTF packaging control instead
# of copying the raw files into /system/vendor.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# ---- vendor/bin ----
# Include all stock vendor daemons and helpers, except a few that are
# provided by the AOSP build (hostapd, ipacm, vndservicemanager) and
# HAL services that the device tree builds from AOSP source.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/bin,$(TARGET_COPY_OUT_VENDOR)/bin)
PRODUCT_COPY_FILES := $(filter-out \
    %/bin/hostapd \
    %/bin/ipacm \
    %/bin/vndservicemanager \
    %/bin/hw/android.hardware.configstore@1.1-service \
    %/bin/hw/android.hardware.graphics.allocator@2.0-service \
    %/bin/hw/android.hardware.graphics.composer@2.1-service \
    %/bin/hw/android.hardware.health@1.0-service \
    %/bin/hw/android.hardware.memtrack@1.0-service \
    %/bin/hw/android.hardware.power@1.0-service \
    %/bin/hw/android.hardware.sensors@1.0-service, \
    $(PRODUCT_COPY_FILES))

# ---- vendor/etc ----
# Include all stock configuration, excluding init scripts and wifi
# configs (which are handled separately below).
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc,$(TARGET_COPY_OUT_VENDOR)/etc)
PRODUCT_COPY_FILES := $(filter-out \
    %/etc/init/% \
    %/etc/wifi/%, \
    $(PRODUCT_COPY_FILES))

# ---- vendor/etc/init ----
# Include all vendor init scripts except:
#   a) HALs that the device tree builds from AOSP source
#   b) Stock init/hw scripts that define hundreds of services for
#      binaries not present on Lineage (init.qcom.rc, etc.)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc/init,$(TARGET_COPY_OUT_VENDOR)/etc/init)
PRODUCT_COPY_FILES := $(filter-out \
    %/etc/init/android.hardware.graphics.allocator@2.0-service.rc \
    %/etc/init/android.hardware.graphics.composer@2.1-service.rc \
    %/etc/init/android.hardware.health@1.0-service.rc \
    %/etc/init/android.hardware.memtrack@1.0-service.rc \
    %/etc/init/android.hardware.power@1.0-service.rc \
    %/etc/init/android.hardware.sensors@1.0-service.rc \
    %/etc/init/hw/init.qcom.rc \
    %/etc/init/hw/init.qcom.factory.rc \
    %/etc/init/hw/init.target.rc \
    %/etc/init/hw/init.vendor.rc, \
    $(PRODUCT_COPY_FILES))

# ---- vendor/etc/wifi ----
# Include all stock wifi configs except the generated wpa_supplicant.conf.
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc/wifi,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)
PRODUCT_COPY_FILES := $(filter-out \
    %/etc/wifi/wpa_supplicant.conf, \
    $(PRODUCT_COPY_FILES))

# ---- vendor/firmware ----
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/firmware,$(TARGET_COPY_OUT_VENDOR)/firmware)

# ---- vendor/lib ----
# Include all stock 32-bit libraries except:
#   a) HAL impls that the device tree builds from AOSP source
#   b) Libraries provided by the AOSP build
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib,$(TARGET_COPY_OUT_VENDOR)/lib)
PRODUCT_COPY_FILES := $(filter-out \
    %/lib/hw/android.hardware.graphics.allocator@2.0-impl.so \
    %/lib/hw/android.hardware.graphics.composer@2.1-impl.so \
    %/lib/hw/android.hardware.graphics.mapper@2.0-impl.so \
    %/lib/hw/android.hardware.health@1.0-impl.so \
    %/lib/android.hardware.tetheroffload.config@1.0.so \
    %/lib/libgnsspps.so \
    %/lib/libgps.utils.so \
    %/lib/libgpustats.so \
    %/lib/librmnetctl.so \
    %/lib/libsdm-disp-vndapis.so \
    %/lib/vendor.display.color@1.0_vendor.so \
    %/lib/vendor.qti.gnss@1.0_vendor.so \
    %/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so, \
    $(PRODUCT_COPY_FILES))
# Re-include qdutils_disp (required by display HAL)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.qdutils_disp@1.0_vendor.so

# ---- vendor/lib64 ----
# Include all stock 64-bit libraries except:
#   a) HAL impls that the device tree builds from AOSP source
#   b) Libraries provided by the AOSP build
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib64,$(TARGET_COPY_OUT_VENDOR)/lib64)
PRODUCT_COPY_FILES := $(filter-out \
    %/lib64/hw/android.hardware.graphics.allocator@2.0-impl.so \
    %/lib64/hw/android.hardware.graphics.composer@2.1-impl.so \
    %/lib64/hw/android.hardware.graphics.mapper@2.0-impl.so \
    %/lib64/hw/android.hardware.health@1.0-impl.so \
    %/lib64/hw/android.hardware.memtrack@1.0-impl.so \
    %/lib64/hw/android.hardware.power@1.0-impl.so \
    %/lib64/hw/android.hardware.sensors@1.0-impl.so \
    %/lib64/android.hardware.tetheroffload.config@1.0.so \
    %/lib64/android.hardware.tetheroffload.control@1.0.so \
    %/lib64/libgnsspps.so \
    %/lib64/libgps.utils.so \
    %/lib64/libgpustats.so \
    %/lib64/librmnetctl.so \
    %/lib64/libsdm-disp-vndapis.so \
    %/lib64/vendor.display.color@1.0_vendor.so \
    %/lib64/vendor.qti.gnss@1.0_vendor.so \
    %/lib64/vendor.qti.hardware.qdutils_disp@1.0_vendor.so, \
    $(PRODUCT_COPY_FILES))
# Re-include qdutils_disp (required by display HAL)
PRODUCT_COPY_FILES += \
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
