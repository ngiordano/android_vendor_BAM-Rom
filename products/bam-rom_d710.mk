# Check for target product
ifeq (bam-rom_d710,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam-rom/overlay/aokp/device/common

# include JELLYBAM common configuration
include vendor/bam-rom/config/bam-rom_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d710/cm.mk)

PRODUCT_NAME := bam-rom_d710

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam-rom/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam-rom/tools/addprojects.py $(PRODUCT_NAME))

endif

