for combo in $(curl https://raw.github.com/BAM-Team/jellybam_vendor/jbam10/bam-build-targets | sed -e 's/#.*$//' | grep jbam10 | awk {'print $1'})
do
    add_lunch_combo $combo
done
