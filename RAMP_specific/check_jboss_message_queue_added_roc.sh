#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
QUEUE_NAME=$4
ENV_TYPE=$5
if [ "$5" = "" ]; then
echo "Too few arguments need 5 - warn crit jboss_host queue_name env_type"
exit 1
fi

# Will populate the variable LAST_VAL and take the variables THIS_SCRIPT, THIS_DIR and VAL_TYPE from this script
THIS_SCRIPT=`basename "$0"`
THIS_DIR=`dirname "$0"`
VAL_TYPE=$JBOSS_HOST-$QUEUE_NAME-$ENV_TYPE
. $THIS_DIR/HELPER_SCRIPTS/get_roc_last_val.sh

CURRENT_VAL=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get "org.hornetq:module=Core,type=Queue,address=\"jms.queue.${QUEUE_NAME}\",name=\"jms.queue.${QUEUE_NAME}\"" MessagesAdded|awk -F= '{print $2}'`

# Will take the variable CURRENT_VALUE from this script and take the variable VAL_TYPE from this script
. $THIS_DIR/HELPER_SCRIPTS/write_last_val_file.sh 

# Will populate the variable ROC and take the variables CURRENT_VAL and LAST_VAL from this script
. $THIS_DIR/HELPER_SCRIPTS/calculate_roc.sh 

if [ "$ROC" -le "$WARN" ]; then
echo "OK: Jboss message queue $QUEUE_NAME is OK at rate of change of $ROC added messages |MessagesAddedROC=$ROC;$WARN;$CRIT"
exit 0
fi

if [ "$ROC" -le "$CRIT" ]; then
echo "WARN: Jboss message queue $QUEUE_NAME rate of change of $ROC added messages and exceeds $WARN |MessagesAddedROC=$ROC;$WARN;$CRIT"
exit 1
fi

if [ "$ROC" -ge "$CRIT" ]; then
echo "CRIT: Jboss message queue $QUEUE_NAME rate of change of $ROC added messages and exceeds $CRIT |MessagesAddedROC=$ROC;$WARN;$CRIT"
exit 2
fi
exit 3




