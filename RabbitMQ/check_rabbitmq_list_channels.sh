#!/bin/bash
WARN=$1
CRIT=$1
if [ "$1" = "" ]; then
echo "Too few arguments need 3 - warn crit volume"
exit 1
fi

OUTPUT=`sudo /usr/sbin/rabbitmqctl -q list_channels | grep nike | wc -l`

if [ "$OUTPUT" = "$WARN" ]; then
echo "OK: count of nike channels is ok at $OUTPUT |nike_channels=$OUTPUT;$WARN;$CRIT;0;0"
exit 0
fi

#if [ "$OUTPUT" -le "$CRIT" ]; then
#echo "WARN: running connection count is warning at $OUTPUT |running_connections=$OUTPUT;$WARN;$CRIT;0;0"
#exit 1
#fi

if [ "$OUTPUT" != "$CRIT" ]; then
echo "CRIT: count of nike channels is crit at $OUTPUT |nike_channels=$OUTPUT;$WARN;$CRIT;0;0"
exit 2
fi
exit 3

