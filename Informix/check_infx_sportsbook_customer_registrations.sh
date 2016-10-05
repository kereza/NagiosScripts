#!/bin/sh
. /home/informix/.profile
WARN=$1
CRIT=$2
QUEUE=ALL

USER=nagios
LIBEXEC=/opt/nagios/libexec/

COUNT=`dbaccess openbet_pri 2>/dev/null <<-EOF
set isolation to dirty read;
SELECT count(cust_id)
FROM tcustomer
WHERE cr_date >= extend ((current - interval (1) minute to minute), year to minute)
AND cr_date <  extend (current, year to minute);
EOF`

FREEREAL=`echo $COUNT | awk '{print $2}'`

if [ "$WARN" -gt "$FREEREAL" ]; then
echo "OK: Customer Registrations: ${FREEREAL}|openbetcustreg=${FREEREAL};$WARN;$CRIT" 
exit 0
fi

if [ "$WARN" -lt "$FREEREAL" -a "$CRIT" -gt "$FREEREAL" ];then
echo "WARN: Customer Registrations: ${FREEREAL}|openbetcustreg=${FREEREAL};$WARN;$CRIT" 
exit 1
fi

if [ "$CRIT" -lt "$FREEREAL" ];then
echo "CRIT: Customer Registrations: ${FREEREAL}|openbetcustreg=${FREEREAL};$WARN;$CRIT" 
exit 2
fi


