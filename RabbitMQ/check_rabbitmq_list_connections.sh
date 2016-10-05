#!/bin/bash
WARN=$1
CRIT=$1
if [ "$1" = "" ]; then
echo "Too few arguments need 3 - warn crit volume"
exit 1
fi

OUTPUT=`sudo /usr/sbin/rabbitmqctl -q list_connections | grep running | wc -l`

if [ "$OUTPUT" =  "$WARN" ]; then
echo "OK: running connection count is ok at $OUTPUT |running_connections=$OUTPUT;$WARN;$CRIT;0;0"
exit 0
fi

#if [ "$OUTPUT" -le "$CRIT" ]; then
#echo "WARN: running connection count is warning at $OUTPUT |running_connections=$OUTPUT;$WARN;$CRIT;0;0"
#exit 1
#fi

if [ "$OUTPUT" != "$CRIT" ]; then
echo "CRIT: running connection count is critical at $OUTPUT |running_connections=$OUTPUT;$WARN;$CRIT;0;0"
exit 2
fi
exit 3

