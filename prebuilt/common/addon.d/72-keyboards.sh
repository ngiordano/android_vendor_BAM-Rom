#!/sbin/sh
# 
# /system/addon.d/72-keyboards.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/iWnnIME.apk
app/iWnnIME_Kbd_White.apk
app/LatinImeGoogle.apk
lib/libiwnn.so
lib/libjni_unbundled_latinimegoogle.so
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
