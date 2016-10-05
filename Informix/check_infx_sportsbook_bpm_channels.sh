#!/bin/sh
. /home/informix/.profile
WARN=$1
CRIT=$2
QUEUE=$3

USER=nagios
LIBEXEC=/opt/nagios/libexec/

COUNT=`dbaccess openbet_pri 2>/dev/null <<-EOF
set isolation to dirty read;
SELECT count(bet_id)
FROM tbet
WHERE cr_date >= extend ((current - interval (1) minute to minute), year to minute)
AND cr_date <  extend (current, year to minute)
AND source = '${QUEUE}';
EOF`

FREEREAL=`echo $COUNT | awk '{print $2}'`

if [ "$WARN" -le "$FREEREAL" ]; then
echo "OK: BPM Source: ${QUEUE} is ${FREEREAL}|bpm_channel_${QUEUE}=${FREEREAL};$WARN;$CRIT" 
exit 0
fi

if [ "$WARN" -ge "$FREEREAL" -a "$CRIT" -le "$FREEREAL" ];then
echo "WARN: BPM Source: ${QUEUE} is ${FREEREAL}|bpm_channel_${QUEUE}=${FREEREAL};$WARN;$CRIT" 
exit 1
fi

if [ "$CRIT" -ge "$FREEREAL" ];then
echo "CRIT: BPM Source: ${QUEUE} is ${FREEREAL}|bpm_channel_${QUEUE}=${FREEREAL};$WARN;$CRIT" 
exit 2
fi


