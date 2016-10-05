#!/bin/bash


if [ "$4" = "" ]; then
echo "usage: $0 warn crit log_directory log_file"
exit 1
fi

WARN=$1
CRIT=$2
LOG_DIR=$3
LOG_FILE=$4


#Check if log file exists
if [ ! -e "${LOG_DIR}/${LOG_FILE}" ]; then
 # print error message and exit
 echo "CRIT: File $LOG_FILE not found"
 exit 2
fi


LOG_TIME=`tail -200 ${LOG_DIR}/${LOG_FILE}| grep INFO | tail -1 | awk '{print $1, $2}'`

LOG_TIME_SECONDS=`date -d "$LOG_TIME" +%s`


CURRENT_TIME_SECONDS=`date +%s`


let "TIME_DIFF = $CURRENT_TIME_SECONDS - $LOG_TIME_SECONDS"


if [ "$TIME_DIFF" -gt "$CRIT" ]; then
  printf "SIS_FEED_PUB CRITICAL -  Last write to $LOG_FILE was $TIME_DIFF seconds ago|last_log_message=$TIME_DIFF;$WARN;$CRIT"
  exit 2

elif [ "$TIME_DIFF" -gt "$WARN" ]; then
  printf "SIS_FEED_PUB WARNING -  Last write to $LOG_FILE was $TIME_DIFF seconds ago|last_log_message=$TIME_DIFF;$WARN;$CRIT"
  exit 1


elif [ "$TIME_DIFF" -le "$WARN" ]; then
  printf "SIS_FEED_PUB OK -  Last write to $LOG_FILE was $TIME_DIFF seconds ago|last_log_message=$TIME_DIFF;$WARN;$CRIT"
  exit 0

fi

