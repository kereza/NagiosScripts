#!/bin/bash
JBOSS_HOST=$1

if [ "$1" = "" ]; then
echo "Too few arguments need 1 - jboss_host"
exit 1
fi

CURRENT_STATE=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get phase-handler:name=HandlerServiceBean,service=HandlerServiceBean,type=ManagementInterface |grep "InQueueStats=BridgeCheckReceiveCount"|awk -F\; '{print $2}'|awk -F\) '{print $1}'`


if [ "$CURRENT_STATE" -ge "1" ]; then
echo "OK: Phase handler bridge check is OK|bridge_check_ok=$CURRENT_STATE"
exit 0
fi

if [ "$CURRENT_STATE" -eq "0" ]; then
echo "CRIT: Phase handler bridge check not received|bridge_check_ok=$CURRENT_STATE"
exit 2
fi

exit 3

