#!/bin/sh
RACK=$1
WARN=$2
CRIT=$3
NARRATIVE=$4

output=`/usr/bin/nodetool  -h localhost ring | grep $RACK | grep -v Up -c`

if [ $output -le $WARN ];then
echo "OK: All Nodes are Up |$NARRATIVE=$output;$WARN;$CRIT"
exit 0
fi
 
if [ $output -ge "$WARN" -a $output -le "$CRIT" ];then
echo "WARN: $output nodes not Up|$NARRATIVE=$output;$WARN;$CRIT"
exit 1
fi

if [ $output -ge "$CRIT" ];then
echo "CRIT: $output nodes not Up|$NARRATIVE=$output;$WARN;$CRIT"
exit 2
fi

