#!/bin/bash
WARN=$1
CRIT=$2
if [ "$2" = "" ]; then
echo "Too few arguments need 2 - warn crit"
exit 1
fi

MAX_IOWAIT=`vmstat 1 5 | tail -5 | awk -v COL=16 '{if(min==""){min=max=$COL}; if($COL>max) {max=$COL}; if($COL< min) {min=$COL}; total+=$COL; count+=1} END {print total/count, min, max}' | awk '{print $3}'`

if [ "$MAX_IOWAIT" -le "$WARN" ]; then
echo "OK:Disk io wait is $MAX_IOWAIT% |iowait=$MAX_IOWAIT%;$WARN;$CRIT;0;100"
exit 0
fi

if [ "$MAX_IOWAIT" -le "$CRIT" ]; then
echo "WARN:Disk io wait is $MAX_IOWAIT% |iowait=$MAX_IOWAIT%;$WARN;$CRIT;0;100"
exit 1
fi

if [ "$MAX_IOWAIT" -ge "$CRIT" ]; then
echo "CRIT:Disk io wait is $MAX_IOWAIT% |iowait=$MAX_IOWAIT%;$WARN;$CRIT;0;100"
exit 2
fi
exit 3




