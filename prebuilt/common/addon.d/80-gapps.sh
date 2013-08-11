#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/DSPManager.apk
app/Gmail.apk
app/GmsCore.apk
app/GoogleBackupTransport.apk
app/GoogleBookmarksSyncAdapter.apk
app/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleFeedback.apk
app/GoogleLoginService.apk
app/GooglePartnerSetup.apk
app/GoogleServicesFramework.apk
app/Hangouts.apk
app/MediaUploader.apk
app/Music.apk
app/NetworkLocation.apk
app/OneTimeInitializer.apk
app/SetupWizard.apk
app/Vending.apk
app/YouTube.apk
etc/g.prop
etc/permissions/com.google.android
etc/permissions/com.google.android
etc/permissions/com.google.widevine
etc/permissions/features.xml
framework/com.google.android
framework/com.google.android
framework/com.google.widevine
lib/libfrsdk.so
lib/libgtalk_jni.so
lib/libgtalk_stabilize.so
lib/libspeexwrapper.so
lib/libvideochat_jni.so
lib/libvorbisencoder.so
lib/soundfx/libaudiopreprocessing.so
lib/soundfx/libbundlewrapper.so
lib/soundfx/libcyanogen-dsp.so
lib/soundfx/libdownmix.so
lib/soundfx/libreverbwrapper.so
lib/soundfx/libvisualizer.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
