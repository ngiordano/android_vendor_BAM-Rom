# Check for target product
ifeq (bam_d2att,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_d2

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/device/d2-common

# include JELLYBAM d2-common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2att/cm.mk)

PRODUCT_NAME := bam_d2att

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

# boot animation
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/bootanimation/720.zip:system/media/bootanimation.zip

endif

