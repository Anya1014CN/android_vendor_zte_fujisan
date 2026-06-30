LOCAL_PATH := vendor/zte/fujisan

FUJISAN_VENDOR_APK_COPY_FILES := \
    $(call find-copy-subdir-files,*.apk,$(LOCAL_PATH)/proprietary/vendor,vendor)

PRODUCT_COPY_FILES += \
    $(filter-out $(FUJISAN_VENDOR_APK_COPY_FILES),$(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor,vendor)) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/system,system)

PRODUCT_PACKAGES += \
    CABLService \
    OptInAppOverlay \
    Perfdump \
    SVIService \
    SecProtect \
    TimeService \
    colorservice
