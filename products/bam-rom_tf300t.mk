# Check for target product
ifeq (bam-rom_tf300t,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_51xx

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam-rom/overlay/aokp/device/common

# include JELLYBAM common configuration
include vendor/bam-rom/config/bam-rom_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf300t/cm.mk)

PRODUCT_NAME := bam-rom_tf300t

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam-rom/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam-rom/tools/addprojects.py $(PRODUCT_NAME))

endif

