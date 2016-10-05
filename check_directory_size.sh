#!/bin/bash
WARN=$1
CRIT=$2
DIR=$3
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit directory"
exit 1
fi

BERKELEY_SIZE=`du -m $DIR | tail -1 | awk '{print $1}'`

if [ "$BERKELEY_SIZE" -le "$WARN" ]; then
echo "OK: Berkeley DB size is ${BERKELEY_SIZE}MB |size_mb=$BERKELEY_SIZE;$WARN;$CRIT"
exit 0
fi

if [ "$BERKELEY_SIZE" -le "$CRIT" ]; then
echo "WARN: Berkeley DB size is ${BERKELEY_SIZE}MB |size_mb=$BERKELEY_SIZE;$WARN;$CRIT"
exit 1
fi

if [ "$BERKELEY_SIZE" -ge "$CRIT" ]; then
echo "CRIT: Berkeley DB size is ${BERKELEY_SIZE}MB |size_mb=$BERKELEY_SIZE;$WARN;$CRIT"
exit 2
fi
exit 3

