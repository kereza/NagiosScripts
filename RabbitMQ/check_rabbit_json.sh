#!/bin/sh
VHOST=$1
QUEUE=$2
VALUE=$3
WARN=$4
CRIT=$5
NARRATIVE=$6

output=`wget --no-check-certificate https://PPmon:wVTTKNuxke8y@localhost:15671/api/queues/nike/ha-nikeOutbound -q -O - | python -c "import sys, json; print json.load(sys.stdin)$VALUE" | sed 's/[.].*//'`  
#echo $output

#if [ $output -le "$WARN" -a $output -le "$CRIT" ];then

if [ $output -le $WARN ];then
echo "OK: All is ok value is only=$output|$NARRATIVE=$output;$WARN;$CRIT"
exit 0
fi
 
if [ $output -ge "$WARN" -a $output -le "$CRIT" ];then
echo "WARN: All is NOT ok value is $output|$NARRATIVE=$output;$WARN;$CRIT"
exit 1
fi

if [ $output -ge "$CRIT" ];then
echo "CRIT: All is NOT ok value is $output|$NARRATIVE=$output;$WARN;$CRIT"
exit 2
fi

