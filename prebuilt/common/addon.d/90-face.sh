#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock.apk
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libfacelock_jni.so
lib/libfilterpack_facedetect.so
lib/libflint_engine_jni_api.so
lib/libgcomm_jni.so
media/video/AndroidInSpace.240p.mp4
media/video/AndroidInSpace.480p.mp4
media/video/Sunset.240p.mp4
media/video/Sunset.480p.mp4
media/LMprec_508.emd
media/PFFprec_600.emd
vendor/pittpatt/models/detection/
vendor/pittpatt/models/recognition/face.face.y0-y0-22-b-N/full_model.bin
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
