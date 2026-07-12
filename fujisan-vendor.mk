LOCAL_PATH := vendor/zte/fujisan

PRODUCT_SOONG_NAMESPACES += \
    vendor/zte/fujisan

# Keep manifest and compatibility matrix under VINTF packaging control instead
# of copying the raw files into /system/vendor.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/vendor/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/bin,$(TARGET_COPY_OUT_VENDOR)/bin)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/etc,$(TARGET_COPY_OUT_VENDOR)/etc)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/firmware,$(TARGET_COPY_OUT_VENDOR)/firmware)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib,$(TARGET_COPY_OUT_VENDOR)/lib)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/lib64,$(TARGET_COPY_OUT_VENDOR)/lib64)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/radio,$(TARGET_COPY_OUT_VENDOR)/radio)

# Stock system-side companions that are not produced by the AOSP build.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/proprietary/system/bin/app6939:$(TARGET_COPY_OUT_SYSTEM)/bin/app6939 \
    $(LOCAL_PATH)/proprietary/system/bin/bt_logger:$(TARGET_COPY_OUT_SYSTEM)/bin/bt_logger \
    $(LOCAL_PATH)/proprietary/system/bin/diag_socket_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/diag_socket_log.sh \
    $(LOCAL_PATH)/proprietary/system/bin/dun-server:$(TARGET_COPY_OUT_SYSTEM)/bin/dun-server \
    $(LOCAL_PATH)/proprietary/system/bin/fgchargerdumper:$(TARGET_COPY_OUT_SYSTEM)/bin/fgchargerdumper \
    $(LOCAL_PATH)/proprietary/system/bin/tloc_daemon:$(TARGET_COPY_OUT_SYSTEM)/bin/tloc_daemon \
    $(LOCAL_PATH)/proprietary/system/bin/usbconfig:$(TARGET_COPY_OUT_SYSTEM)/bin/usbconfig \
    $(LOCAL_PATH)/proprietary/system/etc/dolby/dax-default.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/dolby/dax-default.xml \
    $(LOCAL_PATH)/proprietary/system/etc/permissions/izat.xt.srv.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/izat.xt.srv.xml \
    $(LOCAL_PATH)/proprietary/system/framework/dolby_dax.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/dolby_dax.jar \
    $(LOCAL_PATH)/proprietary/system/framework/izat.xt.srv.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/izat.xt.srv.jar \
    $(LOCAL_PATH)/proprietary/system/lib/libtrueportrait.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libtrueportrait.so \
    $(LOCAL_PATH)/proprietary/system/lib/soundfx/libswdap.so:$(TARGET_COPY_OUT_SYSTEM)/lib/soundfx/libswdap.so \
    $(LOCAL_PATH)/proprietary/system/lib/vendor.qti.gnss@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib/vendor.qti.gnss@1.0.so \
    $(LOCAL_PATH)/proprietary/system/lib64/libtrueportrait.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libtrueportrait.so \
    $(LOCAL_PATH)/proprietary/system/lib64/libzte_zcore.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libzte_zcore.so \
    $(LOCAL_PATH)/proprietary/system/lib64/soundfx/libswdap.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/soundfx/libswdap.so \
    $(LOCAL_PATH)/proprietary/system/lib64/vendor.qti.gnss@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.gnss@1.0.so \
    $(LOCAL_PATH)/proprietary/system/lib64/vendor.qti.hardware.wigig.netperftuner@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.hardware.wigig.netperftuner@1.0.so
