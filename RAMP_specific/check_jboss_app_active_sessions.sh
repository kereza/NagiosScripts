#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
APP_NAME=$4
if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit jboss_host app_name"
exit 1
fi

ACTIVE_SESSIONS=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get "jboss.web:type=Manager,path=/${APP_NAME},host=localhost" activeSessions|awk -F= '{print $2}'`

if [ "$ACTIVE_SESSIONS" -le "$WARN" ]; then
echo "OK: Active Sessions for $APP_NAME is $ACTIVE_SESSIONS |activesessions=$ACTIVE_SESSIONS;$WARN;$CRIT"
exit 0
fi

if [ "$ACTIVE_SESSIONS" -le "$CRIT" ]; then
echo "WARN: Active Sessions for $APP_NAME is $ACTIVE_SESSIONS which exceeds $WARN|activesessions=$ACTIVE_SESSIONS;$WARN;$CRIT"
exit 1
fi

if [ "$ACTIVE_SESSIONS" -ge "$CRIT" ]; then
echo "CRIT: Active Sessions for $APP_NAME is $ACTIVE_SESSIONS which exceeds $CRIT|activesessions=$ACTIVE_SESSIONS;$WARN;$CRIT"
exit 2
fi
exit 3



