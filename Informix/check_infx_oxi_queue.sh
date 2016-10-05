#!/bin/sh
. /home/informix/.profile
WARN=$1
CRIT=$2
QUEUE=$3

USER=nagios
LIBEXEC=/opt/nagios/libexec/

COUNT=`dbaccess openbet_pri 2>/dev/null <<-EOF
set isolation to dirty read;
select TRUNC((select max(msg_id) from toximsg),0) - last_ack_id as queue
from toxirepsess
where name = "$QUEUE";
EOF`

FREEREAL=`echo $COUNT | awk '{print $2}'`

if [ "$WARN" -gt "$FREEREAL" ]; then
echo "OK: OXI Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_oxi_queue=${FREEREAL};$WARN;$CRIT" 
exit 0
fi

if [ "$WARN" -lt "$FREEREAL" -a "$CRIT" -gt "$FREEREAL" ];then
echo "WARN: OXI Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_oxi_queue=${FREEREAL};$WARN;$CRIT" 
exit 1
fi

if [ "$CRIT" -lt "$FREEREAL" ];then
echo "CRIT: OXI Queue: ${QUEUE} is ${FREEREAL} records|${QUEUE}_oxi_queue=${FREEREAL};$WARN;$CRIT" 
exit 2
fi


