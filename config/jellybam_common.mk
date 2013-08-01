# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=ModernBam.wav \
  ro.config.notification_sound=Jellybam.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pa/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pa/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# Installer
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/bin/persist.sh:install/bin/persist.sh \
    vendor/jellybam/prebuilt/common/etc/persist.conf:system/etc/persist.conf

# JELLYBAM-specific init file
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/etc/init.local.rc:root/init.jellybam.rc

#Embed superuser into settings 
SUPERUSER_EMBEDDED := true

# T-Mobile theme engine
include vendor/jellybam/config/themes_common.mk


# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

### AOKP ###
# AOKP Packages
PRODUCT_PACKAGES += \
    PerformanceControl \
    PermissionsManager

### CyanogenMod ###
# CM
PRODUCT_PACKAGES += \
    VoicePlus 

# Extra tools in CM
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    su

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/jellybam/overlay/aokp/common

### PARANOID ###
# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

# ParanoidAndroid Proprietary
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk \
    vendor/jellybam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/jellybam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst jellybam_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Add PA release version
PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 9
PA_VERSION_MAINTENANCE = 0
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

# JELLYBAM version
BAM_VERSION_MAJOR = 10
BAM_VERSION_MINOR = 0
BAM_VERSION_MAINTENANCE = 0
BAM_VERSION := $(BAM_VERSION_MAJOR).$(BAM_VERSION_MINOR).$(BAM_VERSION_MAINTENANCE)

TARGET_CUSTOM_RELEASETOOL := vendor/jellybam/tools/squisher

# goo.im properties
ifneq ($(DEVELOPER_VERSION),true)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.goo.developerid=JellyBam \
      ro.goo.rom=JellyBam \
      ro.goo.version=$(BAM_VERSION) \
      ro.goo.product.device=$(BOARD)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.jellybam.version=$(BAM_VERSION) \
    ro.bamrom.version=jellybam-v$(BAM_VERSION)_$(BOARD) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr2 \
    ro.romstats.url=http://www.bam-android.com/stats/ \
    ro.romstats.name=JELLYBAM \
    ro.romstats.version=$(BAM_VERSION) \
    ro.romstats.tframe=7
