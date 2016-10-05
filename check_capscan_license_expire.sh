# author Federico Prando - federico.prando@paddypower.com
# with a little help by Lorenzo Cipparrone - gcipparrone@paddypower.com
# checks the capscan license expiry date and sends to nagios
# the number of days left before the expiry with the proper exit codes

CAPDIR="/opt/capscan/bin/"
LICENCE="`basename $(ls /opt/capscan/bin/cap*lic)`"
EXPIRE="`cd $CAPDIR ;./readlic $LICENCE | egrep ^Expiry | awk '{print $3}' | awk -F \- '{print $3"-"$2"-"$1 }'`"
EDATE="$(date --date="$EXPIRE" +%s)"
DATE="`date +%s`"
DIFFDATE="`echo "$EDATE - $DATE" | bc`"

OK="864000" # 10 days in seconds
WARN="432000" # 5 days in seconds
CRIT="86400" # 1 day in seconds
W="`echo "432000/86400" | bc`"
C="`echo "86400/86400" | bc`"

DAYS=`echo "$DIFFDATE / 86400" | bc`

if [ "$DIFFDATE" -gt "$OK" ] ; then
        echo "OK: CapScan Expiration Date is $DAYS days away | expires_in=$DAYS;$W;$C"
        exit 0

elif [ "$DIFFDATE" -lt "$OK" -a "$DIFFDATE" -gt "$WARN" ] ; then
        echo "WARN: CapScan Expiration Date is $DAYS days away | expires_in=$DAYS;$W;$C"
        exit 1
else
        echo "CRIT: CapScan Expiration Date is $DAYS day away | expires_in=$DAYS;$W;$C"
        exit 2
fi


