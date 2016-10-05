#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit jboss_host"
exit 1
fi

CURRENT_MEM_FREE=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get 'jboss.system:type=ServerInfo' FreeMemory|awk -F= '{print $2}'`
TOTAL_MEM=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get 'jboss.system:type=ServerInfo' TotalMemory|awk -F= '{print $2}'`

USED_PCT_TOTAL=`echo "$CURRENT_MEM_FREE $TOTAL_MEM" | awk '{ print $1 / $2*100 }'`
FREE_PCT=`echo $USED_PCT_TOTAL|awk -F. '{print $1}'`
USED_PCT=`echo "100 $FREE_PCT" | awk '{ print $1 - $2 }'`

if [ "$USED_PCT" -le "$WARN" ]; then
echo "OK: JVM Memory in use is $USED_PCT% |jvmmem=$USED_PCT%;$WARN;$CRIT;0;100"
exit 0
fi

if [ "$USED_PCT" -le "$CRIT" ]; then
echo "WARN: JVM Memory in use is $USED_PCT% |jvmmem=$USED_PCT%;$WARN;$CRIT;0;100"
exit 1
fi

if [ "$USED_PCT" -ge "$CRIT" ]; then
echo "CRIT: JVM Memory in use is $USED_PCT% |jvmmem=$USED_PCT%;$WARN;$CRIT;0;100"
exit 2
fi
exit 3




