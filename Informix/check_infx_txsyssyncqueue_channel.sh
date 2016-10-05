#!/bin/sh
. /home/informix/.profile
WARN=$1
CRIT=$2
QUEUE=$3

USER=nagios
LIBEXEC=/opt/nagios/libexec/

COUNT=`dbaccess openbet_pri 2>/dev/null <<-EOF
set isolation to dirty read;
select count(*)
from txsyssyncqueue q, txsyshost h 
where h.system_id = q.system_id and processed = 'N'
and h.name = "$QUEUE";
EOF`

FREEREAL=`echo $COUNT | awk '{print $2}'`

if [ "$WARN" -gt "$FREEREAL" ]; then
echo "OK: TXSYSSYNCQUEUE Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_txsyssyncqueue=${FREEREAL};$WARN;$CRIT" 
exit 0
fi

if [ "$WARN" -lt "$FREEREAL" -a "$CRIT" -gt "$FREEREAL" ];then
echo "WARN: TXSYSSYNCQUEUE Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_txsyssyncqueue=${FREEREAL};$WARN;$CRIT" 
exit 1
fi

if [ "$CRIT" -lt "$FREEREAL" ];then
echo "CRIT: TXSYSSYNCQUEUE Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_txsyssyncqueue=${FREEREAL};$WARN;$CRIT" 
exit 2
fi


