#!/bin/bash

WARN=$1
CRIT=$2
DIR_PATH=$3
USE_SIS_DATE=$4

if [ "$4" = "" ]; then
echo "Too few arguments need 4 - warn crit dir_path use_sis_date"
exit 1
fi

TODAY=`date +"%Y-%m-%d"`

if [ "$USE_SIS_DATE" = "Y" ]; then
        DIR_PATH=$DIR_PATH/$TODAY/HR
fi


if [ ! -e $DIR_PATH ]; then
  echo "FILE_AGE CRIT - The directory $DIR_PATH does not exist"
  exit 2
fi


WARN_SECONDS=$(($WARN * 60))
CRIT_SECONDS=$(($CRIT * 60))


last_file=`ls -ltr $DIR_PATH | tail -1 | awk '{print $9}'`
file_time=`date +%s -r ${DIR_PATH}/$last_file`
current_time=`date +%s`

time_diff=$(($current_time - $file_time))
time_diff_minutes=$(($time_diff / 60 ))


if [ "$time_diff" -ge "$CRIT_SECONDS" ]; then
  echo "FILE_AGE CRIT - Last file modification was $time_diff_minutes minute(s) ago in $DIR_PATH |last_file_mod_min=$time_diff_minutes;$WARN;$CRIT"
  exit 2

elif [ "$time_diff" -ge "$WARN_SECONDS" ]; then
  echo "FILE_AGE WARN - Last file modification was $time_diff_minutes minute(s) ago in $DIR_PATH |last_file_mod_min=$time_diff_minutes;$WARN;$CRIT"
  exit 1

elif [ "$time_diff" -lt "$WARN_SECONDS" ]; then
  echo "FILE_AGE OK - Last file modification was $time_diff_minutes minute(s) ago in $DIR_PATH |last_file_mod_min=$time_diff_minutes;$WARN;$CRIT"
  exit 0
fi

exit 3

