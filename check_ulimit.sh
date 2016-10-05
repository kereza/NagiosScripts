#!/bin/sh
USERNAME=$1
EXPECTED=$2
HOST=$3

#COUNT=`ssh $HOST cat /etc/security/limits.conf | grep $USERNAME | grep -v '#' | awk '{print $EXPECTED}' | uniq`
COUNT=`cat /etc/security/limits.conf | grep $USERNAME | grep -v '#' | awk '{print $4}' | uniq`
if [ "$COUNT" == "$2" ]; then
echo "OK: $1 ulimit is as expected at $2"
exit 0
fi

if [ "$COUNT" != "$2" ]; then
echo "CRIT: $1 ulimit is NOT as expected($2). Currently $COUNT"
exit 2 
fi
