#!/bin/bash

#LOG_FILE=/var/log/messages
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKOWN=3
VAR="ERROR"
WARN=5
CRIT=1

if [ $# == 4 ]; then
        WARN=$1
        CRIT=$2
        VAR=$3
        LOG_FILE=$4
else
        echo "Usage $0 <warning> <critical> <keyword> <logfile> "
        exit $STATE_UNKOWN
fi

#Check if log file exists
if [ ! -e "$LOG_FILE" ]; then
 # print error message and exit
 echo "File $LOG_FILE not found"
 exit $STATE_UNKOWN
fi

#REMOVE SPACES of keyword
VARP=`echo $VAR | sed "s/[ \t][ \t]*//g"`
#Create Lock and Temp file_manager
LOCK="/tmp/log-$VARP.pid"
TMP="/tmp/log-$VARP.tmp"


#DEBUG MODE (uncomment below)
#set -x


# Addresses bug in original script so that the pid file
# is removed if the 'tail' process is killed

TAIL_RUNNING=`ps a -U nagios | grep tail | grep $LOG_FILE`
if [ -z "$TAIL_RUNNING" ] && [ -f "$LOCK" ]; then
  rm $LOCK
fi


# Remove the lock file if the log has been rotated
# so that the tail is restarted so that it points to the new
# file


LOG_START_TIME=`head -1 $LOG_FILE | awk '{print $2}'`
LOG_START_TIME_SECONDS=`date -d "$LOG_TIME" +%s`
CURRENT_TIME_SECONDS=`date +%s`

let "TIME_DIFF = $CURRENT_TIME_SECONDS - $LOG_START_TIME_SECONDS"
if [ "$TIME_DIFF" -lt 180 ]; then
  rm -f $LOCK
fi


#Check if the tail is running
if [ -f "$LOCK"  ]; then
        count_errors=`strings $TMP |grep "$VAR" | wc -l`
#Zero out the file but tail keeps runs
        `> $TMP`
else
        printf  "UNKNOWN - Log 'tail' is not running, executing now for next check"
        pkill -u nagios tail
       `nohup tail -f $LOG_FILE |grep --line-buffered "$VAR" > "$TMP" &`
        touch $LOCK
        exit $STATE_UNKOWN
fi

if [ "$count_errors" -ge "$CRIT" ] ; then
        printf  "CRTICAL - Exists $count_errors errors $VAR in $LOG_FILE|$VAR=$count_errors,$WARN,$CRIT"
        exit $STATE_CRITICAL

elif [ "$count_errors" -ge "$WARN" ] ; then
        printf "WARNING - Exists $count_errors errors $VAR in $LOG_FILE|$VAR=$count_errors,$WARN,$CRIT"
        exit $STATE_WARNING

elif [ "$count_errors" -le "$WARN" ]; then
        printf "OK - Exists $count_errors errors $VAR in $LOG_FILE|$VAR=$count_errors,$WARN,$CRIT"
        exit $STATE_OK
fi
