#!/bin/bash

LOG_FILE=$1
WARN=$2
CRIT=$3

if [ "$3" = "" ]
then
  echo "Too few arguments need 3 - warn crit path_to_log_file"
exit 1
fi


DATE=`tail -1000 $LOG_FILE | grep 'Openbet-Ramp Mapper: data mapping and synchronization executed' | awk '{print $2}' | sed -e 's/,[0-9]*$//' | tail -1`

if [ $DATE ]
then
  LAST_OCCURRENCE=`date -d$DATE +%s`
  NOW=`date +%s`
  ((TIME_DIFF=NOW-LAST_OCCURRENCE))
else
  exit 3
fi

if ((TIME_DIFF<WARN))
then
  echo "HORSE_RACING_MAPPER OK: $TIME_DIFF seconds since last executted is < $WARN|process_executed=1"
exit 0
fi

if ((TIME_DIFF>=WARN && TIME_DIFF<CRIT))
then
  echo "HORSE_RACING_MAPPER WARN: $TIME_DIFF seconds since last executted is >$WARN and <$CRIT|process_executed=1"
exit 1
fi

if ((TIME_DIFF>=CRIT))
then
  echo "HORSE_RACING_MAPPER CRIT: $TIME_DIFF seconds since last executted is > $CRIT|process_executed=0"
exit 2
fi

exit 3
