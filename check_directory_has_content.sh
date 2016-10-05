#!/bin/bash
DIR=$1
if [ "$1" = "" ]; then
echo "Too few arguments need 1 - directory"
exit 1
fi

ls $DIR/* &> /dev/null
CURRENT_STATE=$?

if [ "$CURRENT_STATE" -eq "0" ]; then
echo "OK: Directory $DIR has content|dirhascontent=1"
exit 0
fi

if [ "$CURRENT_STATE" -ne 0 ]; then
echo "CRIT: Directory $DIR has NO content|dirhascontent=0"
exit 2
fi

exit 3

