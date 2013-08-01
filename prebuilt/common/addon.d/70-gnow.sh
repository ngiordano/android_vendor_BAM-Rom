#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
usr/srec/config/en.us/dictionary/cmu6plus.ok.zip
usr/srec/config/en.us/dictionary/basic.ok
usr/srec/config/en.us/dictionary/enroll.ok
usr/srec/config/en.us/baseline.par
usr/srec/config/en.us/grammars/phone_type_choice.g2g
usr/srec/config/en.us/grammars/boolean.g2g
usr/srec/config/en.us/grammars/VoiceDialer.g2g
usr/srec/config/en.us/baseline8k.par
usr/srec/config/en.us/models/generic8_f.swimdl
usr/srec/config/en.us/models/generic.swiarb
usr/srec/config/en.us/models/generic11_f.swimdl
usr/srec/config/en.us/models/generic8_m.swimdl
usr/srec/config/en.us/models/generic11.lda
usr/srec/config/en.us/models/generic11_m.swimdl
usr/srec/config/en.us/models/generic8.lda
usr/srec/config/en.us/baseline11k.par
usr/srec/config/en.us/g2p/en-US-ttp.data
usr/srec/en-US/symbols
usr/srec/en-US/lintrans_model
usr/srec/en-US/g2p_fst
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/embed_phone_nn_model
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/metadata
usr/srec/en-US/contacts.abnf
usr/srec/en-US/norm_fst
usr/srec/en-US/rescoring_lm
usr/srec/en-US/clg
usr/srec/en-US/hmmsyms
usr/srec/en-US/dict
usr/srec/en-US/normalizer
usr/srec/en-US/google_hotword_clg
usr/srec/en-US/google_hotword.config
usr/srec/en-US/grammar.config
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/c_fst
usr/srec/en-US/dictation.config
usr/srec/en-US/google_hotword_logistic
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/embed_phone_nn_state_sym
usr/srec/en-US/phonelist
usr/srec/en-US/hotword_symbols
usr/srec/en-US/acoustic_model
app/VoiceSearchStub.apk
app/GoogleEars.apk
app/GoogleTTS.apk
app/VoiceDialer.apk
tts/lang_pico/en-US_lh0_sg.bin
tts/lang_pico/en-US_ta.bin
tts/lang_pico/de-DE_ta.bin
tts/lang_pico/en-GB_ta.bin
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/it-IT_cm0_sg.bin
tts/lang_pico/es-ES_ta.bin
tts/lang_pico/fr-FR_nk0_sg.bin
tts/lang_pico/de-DE_gl0_sg.bin
tts/lang_pico/en-GB_kh0_sg.bin
tts/lang_pico/fr-FR_ta.bin
tts/lang_pico/it-IT_ta.bin
lib/libpatts_engine_jni_api.so
lib/libgoogle_recognizer_jni.so
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
