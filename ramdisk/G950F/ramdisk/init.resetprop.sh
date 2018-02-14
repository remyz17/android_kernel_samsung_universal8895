#!/system/bin/sh
#
# mwilky

LOGFILE=/data/resetprop.log
BINPATH=/sbin

rm $LOGFILE

mount -o remount,rw /;
mount -o rw,remount /system

log_print() {
  echo "$1"
  echo "$1" >> $LOGFILE
  log -p i -t resetprop "$1"
}

log_print "**Fixing security flags $( date +"%m-%d-%Y %H:%M:%S" )**"

file=/system/etc/renovate/resetprop
cmd=$BINPATH/resetprop

while IFS= read -r line
do
	$cmd -p `echo $line|tr = ' '`
	log_print "$cmd -p `echo $line|tr = ' '`"
done < $file

mount -o remount,ro /;
mount -o ro,remount /system

