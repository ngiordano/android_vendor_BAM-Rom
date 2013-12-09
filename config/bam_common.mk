# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/cm/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# Installer
PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bin/persist.sh:install/bin/persist.sh \
    vendor/bam/prebuilt/common/etc/persist.conf:system/etc/persist.conf

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/bam/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/bam/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

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

# BAM
PRODUCT_PACKAGES += \
  BAMPapers \
  BAMControl \
  BAMSetup \
  ScreenRecorder \
  libscreenrecorder

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/bam/overlay/aokp/common

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

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
BAM_VERSION_MAJOR = 2
BAM_VERSION_MINOR = 0
BAM_VERSION_MAINTENANCE = $(shell date -u +%Y%m%d)
BAM_VERSION := $(BAM_VERSION_MAJOR).$(BAM_VERSION_MINOR)_$(BAM_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.version=$(BAM_VERSION) \
    ro.bam.version=$(BAM_VERSION) \
    ro.bam-rom.version=BAM-Rom_$(BAM_VERSION)_KitKat-$(BOARD) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr2 \
    ro.romstats.url=http://stats.bam-android.com/ \
    ro.romstats.name=BAM-ROM \
    ro.romstats.version=$(BAM_VERSION) \
    ro.romstats.tframe=7 \
    ro.build.selinux=1 \
    ro.adb.secure=3 \
    persist.sys.root_access=3
