#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
DESTINATION_NAME=$4
APP_COUNT_TYPE=$5
ENV_TYPE=$6

if [ "$6" = "" ]; then
echo "Too few arguments need 6 - warn crit jboss_host destination_name app_count_type env_type"
exit 1
fi

# Will populate the variable LAST_VAL and take the variables THIS_SCRIPT, THIS_DIR and VAL_TYPE from this script
THIS_SCRIPT=`basename "$0"`
THIS_DIR=`dirname "$0"`
VAL_TYPE=$JBOSS_HOST-$DESTINATION_NAME-$APP_COUNT_TYPE-$ENV_TYPE
. $THIS_DIR/HELPER_SCRIPTS/get_roc_last_val.sh

CURRENT_VAL=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get phase-handler:name=HandlerServiceBean,service=HandlerServiceBean,type=ManagementInterface | grep $DESTINATION_NAME | grep "^${APP_COUNT_TYPE}" | awk -F, '{print $1}' | awk '{print $3}'`

# Will take the variable CURRENT_VALUE from this script and take the variable VAL_TYPE from this script
. $THIS_DIR/HELPER_SCRIPTS/write_last_val_file.sh

# Will populate the variable ROC and take the variables CURRENT_VAL and LAST_VAL from this script
. $THIS_DIR/HELPER_SCRIPTS/calculate_roc.sh

if [ "$ROC" -le "$WARN" ]; then
echo "OK: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME is OK at rate of change $ROC packets |$APP_COUNT_TYPE=$ROC;$WARN;$CRIT"
exit 0
fi

if [ "$ROC" -le "$CRIT" ]; then
echo "WARN: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME rate of change is $ROC which exceeds $WARN |$APP_COUNT_TYPE=$ROC;$WARN;$CRIT"
exit 1
fi

if [ "$ROC" -ge "$CRIT" ]; then
echo "CRIT: Jboss application count $APP_COUNT_TYPE for $DESTINATION_NAME rate of change is $ROC which exceeds $CRIT |$APP_COUNT_TYPE=$ROC;$WARN;$CRIT"
exit 2
fi
exit 3
