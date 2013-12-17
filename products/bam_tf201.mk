# Check for target product
ifeq (bam_tf201,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_p31xx

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/device/tf201

# include JELLYBAM common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf201/cm.mk)

PRODUCT_NAME := bam_tf201

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

# boot animation
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip

endif

