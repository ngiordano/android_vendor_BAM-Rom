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
    vendor/bam/prebuilt/common/bin/persist.sh:install/bin/persist.sh \
    vendor/bam/prebuilt/common/etc/persist.conf:system/etc/persist.conf

# BAM-Rom-specific init file
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/etc/init.local.rc:root/init.bam.rc

#Embed superuser into settings 
SUPERUSER_EMBEDDED := true

# Using Custom ReleaseRool
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := vendor/bam/overlay/build/tools/releasetools/ota_from_target_files

# T-Mobile theme engine
include vendor/bam/config/themes_common.mk

# init.d support
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/bam/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/bam/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/bam/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/bam/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/bam/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/bam/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/bam/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/bam/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/bam/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/bam/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/bam/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/bam/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/bam/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# Gesture enabled JNI
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

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
    VoicePlus \
    Focal

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
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/common

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
    vendor/bam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/bam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst bam_,,$(TARGET_PRODUCT))

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

# BAM-Rom version
BAM_VERSION_MAJOR = 1
BAM_VERSION_MINOR = 0
BAM_VERSION_MAINTENANCE = 0-RC1
BAM_VERSION := $(BAM_VERSION_MAJOR).$(BAM_VERSION_MINOR).$(BAM_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.bam.version=$(BAM_VERSION) \
    ro.bam-rom.version=BAM-Rom_v$(BAM_VERSION)_JellyBean-$(BOARD) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr2 \
    ro.romstats.url=http://www.bam-android.com/stats/ \
    ro.romstats.name=BAM-Rom \
    ro.romstats.version=$(BAM_VERSION) \
    ro.romstats.tframe=7 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    persist.sys.root_access=3
