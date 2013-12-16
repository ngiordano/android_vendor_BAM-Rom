# Check for target product
ifeq (bam_e975,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/common

# include JELLYBAM common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/e975/cm.mk)

PRODUCT_NAME := bam_e975

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

# boot animation
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bootanimation/768.zip:system/media/bootanimation.zip

endif

