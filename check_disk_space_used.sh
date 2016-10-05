#!/bin/bash
WARN=$1
CRIT=$2
VOLUME=$3
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit volume"
exit 1
fi

VOLUME_USED_PERCENT=`df -h | grep "$VOLUME" | awk '{print $5}' | awk -F% '{print $1}'`

if [ "$VOLUME_USED_PERCENT" -le "$WARN" ]; then
echo "OK: Disk Space used on $VOLUME is ${VOLUME_USED_PERCENT}% |used_percent=$VOLUME_USED_PERCENT%;$WARN;$CRIT;0;100"
exit 0
fi

if [ "$VOLUME_USED_PERCENT" -le "$CRIT" ]; then
echo "WARN: Disk Space used on $VOLUME is ${VOLUME_USED_PERCENT}% |used_percent=$VOLUME_USED_PERCENT%;$WARN;$CRIT;0;100"
exit 1
fi

if [ "$VOLUME_USED_PERCENT" -ge "$CRIT" ]; then
echo "CRIT: Disk Space used on $VOLUME is ${VOLUME_USED_PERCENT}% |used_percent=$VOLUME_USED_PERCENT%;$WARN;$CRIT;0;100"
exit 2
fi
exit 3

