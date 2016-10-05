#!/bin/bash
#
# Array health check plugin for Dell PERC RAID arrays
# Requires the Dell OpenManage Server Administrator software
# be installed on the monitored host.
#
# Written by Josh Malone (jmalone@ubergeeks.com)
# Last modified: 09-17-2007
#
# v 0.1 First functional plugin deployed at NRAO
# v 0.1 Better error checking
#	Recognize a disk that's rebuilding as OK
# v 0.5 Run without arguments to check all arrays on
#	the controller
# v 0.6 Handle intances where the controller doesn't
#	show up as errors
#


# Change this if you have installed the openmanage server admin tools
# somewhere else or have not created the symlink
OMREPORT='/opt/dell/srvadmin/bin/omreport'

PROGNAME=`basename $0`
PROGPATH=`echo $0 | /bin/sed -e 's,[\\/][^\\/][^\\/]*$,,'`

#. $PROGPATH/utils.sh

printusage() {
	echo "Usage: $PROGNAME -C <controller> -V <vdisk>"
	exit $STATE_UNKNOWN
}

while getopts C:V: arg ; do
    case $arg in
    	V) vdisk="vdisk=$OPTARG" ;;
	C) controller=$OPTARG ;;
	h|\?) printusage ;;
	*) printusage ;;
    esac
done

if ! [ -x "$OMREPORT" ]; then
	echo "UNKNOWN: omreport not found"
	exit $STATE_UNKNOWN
fi

rawoutput="$($OMREPORT storage vdisk controller=$controller $vdisk| grep -e 'State *:' -e 'ID *:' | awk '{print $3}' )" 

thestate=$STATE_OK
state="OK"
statout=""

if [ -z "$rawoutput" ]; then
	statout=" Controller $controller not found!"
	state="CRITICAL"
	thestate=$STATE_CRITICAL
fi

for line in $rawoutput; do
    case $line in
        [0-9])
		vdisk=$line
		;;
	Ready|ready)
		statout="${statout} Array $vdisk is $line"
		;;
	Rebuilding|rebuilding)
		statout="${statout} Array $vdisk is $line"
		;;
	Background|Resynching)
		statout="${statout} Array $vdisk is $line"
		state="WARNING"
		thestate=$STATE_WARNING
		;;
	''|\n)
		statout="${statout} Array $vdisk not found"
		state="UNKNOWN"
		thestate=$STATE_UNKNOWN
		BLAH='empty'
		;;
	*)
		statout="${statout} Array $vdisk is $line"
		state="CRITICAL"
		thestate=$STATE_CRITICAL
		BLAH='default'
		;;
    esac
done

echo "${state}:${statout}"

exit $thestate

# Shouldn't get here so exit warning if we do
echo "WARNING: abnormal plugin exit"
exit $STATE_WARNING

