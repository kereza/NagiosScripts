#!/bin/bash


WARN=$1
CRIT=$2
JBOSS_HOST=$3
DEST_NAME=$4


if [ "$4" = "" ]; then
echo "Too few arguments need 4 - warn crit jboss_host destination_name"
exit 1
fi

COUNT=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get phase-engine:name=EngineServiceBean,service=EngineServiceBean,type=ManagementInterface ActivePacketCounts|grep $DEST_NAME|awk '{print $3}'|awk -F, '{print $1}'`

if [ "$COUNT" -le "$WARN" ]; then
echo "OK: Engine active packets for $DEST_NAME is OK at $COUNT packets |ActivePacketCount=$COUNT;$WARN;$CRIT"
exit 0
fi

if [ "$COUNT" -le "$CRIT" ]; then
echo "WARN: Engine active packets for $DEST_NAME is at filling up at $COUNT packets and exceeds $WARN |ActivePacketCount=$COUNT;$WARN;$CRIT"
exit 1
fi

if [ "$COUNT" -ge "$CRIT" ]; then
echo "CRIT: Engine active packets is backlogged for $DEST_NAME at $COUNT packets and exceeds $CRIT |ActivePacketCount=$COUNT;$WARN;$CRIT"
exit 2
fi
exit 3
