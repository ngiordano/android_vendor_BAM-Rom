# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

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

# Using Custom ReleaseRool
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := vendor/jellybam/overlay/build/tools/releasetools/ota_from_target_files

# T-Mobile theme engine
include vendor/jellybam/config/themes_common.mk

# init.d support
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/jellybam/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/jellybam/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/jellybam/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/jellybam/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/jellybam/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/jellybam/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/jellybam/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/jellybam/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/jellybam/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/jellybam/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/jellybam/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/jellybam/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/jellybam/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# Gesture enabled JNI
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/jellybam/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

### AOKP ###
# AOKP Packages
PRODUCT_PACKAGES += \
    PerformanceControl

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
PA_VERSION_MAINTENANCE = 9-RC2
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

# JELLYBAM version
BAM_VERSION_MAJOR = 10
BAM_VERSION_MINOR = 4
BAM_VERSION_MAINTENANCE = 0
BAM_VERSION := $(BAM_VERSION_MAJOR).$(BAM_VERSION_MINOR).$(BAM_VERSION_MAINTENANCE)

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
    ro.romstats.tframe=7 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    persist.sys.root_access=3
