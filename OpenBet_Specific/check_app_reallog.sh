#!/bin/bash
LINES=$1
STRING=$2

source /opt/openbet/site_management/openbet_bash
COUNT=`/opt/openbet/site_management/obcontrol --apps --tail $LINES | grep $STRING -c`

if [ "$COUNT" == 0 ]; then
echo "OK: No Errors of type $STRING found|error_count=$COUNT;0;0"
exit 0
fi

if [ "$COUNT" > 0 ]; then
echo "CRIT: $COUNT Errors of type $STRING found|error_count=$COUNT;0;0"
exit 2
fi

exit 3

