#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit jboss_host"
exit 1
fi

CURRENT_THREADS=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get 'jboss.system:type=ServerInfo' ActiveThreadCount|awk -F= '{print $2}'`

if [ "$CURRENT_THREADS" -le "$WARN" ]; then
echo "OK: JVM Threads in use is $CURRENT_THREADS |threadcnt=$CURRENT_THREADS;$WARN;$CRIT"
exit 0
fi

if [ "$CURRENT_THREADS" -le "$CRIT" ]; then
echo "WARN: JVM Threads in use is $CURRENT_THREADS which exceeds $WARN|threadcnt=$CURRENT_THREADS;$WARN;$CRIT"
exit 1
fi

if [ "$CURRENT_THREADS" -ge "$CRIT" ]; then
echo "CRIT: JVM Threads in use is $CURRENT_THREADS which exceeds $CRIT|threadcnt=$CURRENT_THREADS;$WARN;$CRIT"
exit 2
fi
exit 3



