#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
etc/g.prop
etc/permissions/com.google.android.media.effects.xml
etc/permissions/features.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/preferred-apps/google.xml
framework/com.google.widevine.software.drm.jar
framework/com.google.android.media.effects.jar
framework/com.google.android.maps.jar
app/MusicFX.apk
app/Vending.apk
app/GoogleOneTimeInitializer.apk
app/LatinImeDictionaryPack.apk
app/NetworkLocation.apk
app/GoogleFeedback.apk
app/Gmail.apk
app/GoogleBackupTransport.apk
app/MediaUploader.apk
app/GoogleContactsSyncAdapter.apk
app/SetupWizard.apk
app/GooglePartnerSetup.apk
app/ChromeBookmarksSyncAdapter.apk
app/ConfigUpdater.apk
app/GoogleLoginService.apk
app/Hangouts.apk
app/DSPManager.apk
app/Music.apk
app/Calendar.apk
app/GoogleServicesFramework.apk
app/GoogleCalendarSyncAdapter.apk
app/YouTube.apk
app/GmsCore.apk
lib/libwebrtc_audio_coding.so
lib/libgtalk_stabilize.so
lib/libpatts_engine_jni_api.so
lib/libAppDataSearch.so
lib/libgtalk_jni.so
lib/libfilterpack_facedetect.so
lib/libjni_t13n_shared_engine.so
lib/libspeexwrapper.so
lib/libvorbisencoder.so
lib/libgames_rtmp_jni.so
lib/libfrsdk.so
lib/libgoogle_recognizer_jni_l.so
lib/libvideochat_jni.so
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
