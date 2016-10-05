#!/bin/bash

WARN=$1
CRIT=$2
JBOSS_HOST=$3
DESTINATION_NAME=$4
APP_COUNT_TYPE=$5


if [ "$5" = "" ]; then
echo "Too few arguments need 5 - warn crit jboss_host destination_name app_count_type"
exit 1
fi

COUNT=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get phase-handler:name=HandlerServiceBean,service=HandlerServiceBean,type=ManagementInterface | grep $DESTINATION_NAME | grep $APP_COUNT_TYPE | awk -F, '{print $1}' | awk '{print $3}'`

if  ! [[ "$COUNT"  =~ ^[0-9]+$ ]]; then
    echo "WARN: $APP_COUNT_TYPE not found for destination $DESTINATION_NAME"
    exit 1
fi

if [ "$COUNT" -le "$WARN" ]; then
    echo "OK: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME is OK at $COUNT |$APP_COUNT_TYPE=$COUNT;$WARN;$CRIT"
    exit 0
fi

if [ "$COUNT" -le "$CRIT" ]; then
    echo "WARN: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME is $COUNT which is over $WARN |$APP_COUNT_TYPE=$COUNT;$WARN;$CRIT"
    exit 1
fi

if [ "$COUNT" -ge "$CRIT" ]; then
    echo "CRIT: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME is $COUNT which is over $CRIT |$APP_COUNT_TYPE=$COUNT;$WARN;$CRIT"
    exit 2
fi
exit 3
