#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
QUEUE_NAME=$4
if [ "$4" = "" ]; then
echo "Too few arguments need 4 - warn crit jboss_host queue_name"
exit 1
fi

CURRENT_MESSAGE_COUNT=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get "org.hornetq:module=Core,type=Queue,address=\"jms.queue.${QUEUE_NAME}\",name=\"jms.queue.${QUEUE_NAME}\"" MessageCount|awk -F= '{print $2}'`


if [ "$CURRENT_MESSAGE_COUNT" -le "$WARN" ]; then
echo "OK: Jboss message queue $QUEUE_NAME is OK at $CURRENT_MESSAGE_COUNT messages |MessageCount=$CURRENT_MESSAGE_COUNT;$WARN;$CRIT;$MIN;$MAX"
exit 0
fi

if [ "$CURRENT_MESSAGE_COUNT" -le "$CRIT" ]; then
echo "WARN: Jboss message queue $QUEUE_NAME is at filling up at $CURRENT_MESSAGE_COUNT messages and exceeds $WARN |MessageCount=$CURRENT_MESSAGE_COUNT;$WARN;$CRIT;$MIN;$MAX"
exit 1
fi

if [ "$CURRENT_MESSAGE_COUNT" -ge "$CRIT" ]; then
echo "CRIT: Jboss message queue $QUEUE_NAME is backlogged at $CURRENT_MESSAGE_COUNT messages and exceeds $CRIT |MessageCount=$CURRENT_MESSAGE_COUNT;$WARN;$CRIT;$MIN;$MAX"
exit 2
fi
exit 3




