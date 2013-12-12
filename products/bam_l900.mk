# Check for target product
ifeq (bam_l900,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_n7100

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/common

# include JELLYBAM common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/l900/cm.mk)

PRODUCT_NAME := bam_l900

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

# boot animation
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bootanimation/720.zip:system/media/bootanimation.zip

endif

