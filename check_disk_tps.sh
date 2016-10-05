#!/bin/bash
WARN=$1
CRIT=$2
VOLUME_NAME=$3
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit volume_name"
exit 1
fi

MAX_TPS_FLOAT=`iostat 1 5 | grep "^${VOLUME_NAME} " | awk -v COL=2 '{if(min==""){min=max=$COL}; if($COL>max) {max=$COL}; if($COL< min) {min=$COL}; total+=$COL; count+=1} END {print total/count, min, max}' | awk '{print $3}'`

#Convert float to integer
MAX_TPS=${MAX_TPS_FLOAT/.*}

if [ "$MAX_TPS" -le "$WARN" ]; then
echo "OK:Disk tps is $MAX_TPS |tps=$MAX_TPS;$WARN;$CRIT"
exit 0
fi

if [ "$MAX_TPS" -le "$CRIT" ]; then
echo "WARN:Disk tps is $MAX_TPS |tps=$MAX_TPS;$WARN;$CRIT"
exit 1
fi

if [ "$MAX_TPS" -ge "$CRIT" ]; then
echo "CRIT:Disk tps is $MAX_TPS |tps=$MAX_TPS;$WARN;$CRIT"
exit 2
fi
exit 3




