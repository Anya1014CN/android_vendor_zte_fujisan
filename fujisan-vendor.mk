LOCAL_PATH := vendor/zte/fujisan

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor,vendor) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/system,system)
