# Check for target product
ifeq (bam_shootervm,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/device/shooter

# include JELLYBAM common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/shootervm/cm.mk)

PRODUCT_NAME := bam_shootervm

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

endif

