#!/bin/bash
JBOSS_HOST=$1

if [ "$1" = "" ]; then
echo "Too few arguments need 1 - jboss_host"
exit 1
fi

CURRENT_STATE=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get phase-handler:name=HandlerServiceBean,service=HandlerServiceBean,type=ManagementInterface DestinationsCurrentlyRetrying |grep -c None`

if [ "$CURRENT_STATE" -eq "1" ]; then
echo "OK: Jboss handler is OK|Current delivery retries=0"
exit 0
fi

if [ "$CURRENT_STATE" -eq "0" ]; then
echo "CRIT: Phase handler is retrying packet delivery|Current delivery retries=1"
exit 2
fi

exit 3
