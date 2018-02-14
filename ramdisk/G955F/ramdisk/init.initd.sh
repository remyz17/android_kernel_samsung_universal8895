#!/system/bin/sh
#
# mwilky

LOGFILE=/data/initd.log

rm $LOGFILE

mount -o remount,rw /;
mount -o rw,remount /system

log_print() {
  echo "$1"
  echo "$1" >> $LOGFILE
}

log_print "**RENOVATE init.d started at $( date +"%m-%d-%Y %H:%M:%S" )**"

# init.d support
if [ ! -e /system/etc/init.d ]; then
	mkdir /system/etc/init.d
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
fi

# start init.d
for FILE in /system/etc/init.d/*; do
	sh $FILE >/dev/null
	log_print "$FILE ran at $( date +"%m-%d-%Y %H:%M:%S" )"
done;

mount -o remount,ro /;
mount -o ro,remount /system

