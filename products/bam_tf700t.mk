# Check for target product
ifeq (bam_tf700t,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tf300t

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/common-tablet

# include JELLYBAM common configuration
include vendor/bam/config/bam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/asus/tf700t/cm.mk)

PRODUCT_NAME := bam_tf700t

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/bam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/bam/tools/addprojects.py $(PRODUCT_NAME))

# should be 1200
# boot animation
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bootanimation/1080.zip:system/media/bootanimation.zip

endif

