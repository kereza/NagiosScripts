#!/bin/bash
File=$1
WARN=$2
CRIT=$3

DATE=`/bin/date +%s`

if [ "$3" = "" ]
then
  echo "Too few arguments need 3 - warn crit file_name"
exit 1
fi

if [ -e ${File} ]
then
  fdate=`/bin/date -r ${File} +%s`
  ((tdiff=DATE-fdate))
else
  echo "CRIT: File does not exist"
  exit 2
fi



if ((tdiff<WARN))
then
  echo "OK: $File - $tdiff seconds is < $WARN"
exit 0
fi

if ((tdiff>=WARN && tdiff<CRIT))
then
  echo "WARN: $File - $tdiff seconds is > $WARN and <$CRIT"
exit 1
fi

if ((tdiff>=CRIT))
then
  echo "CRIT: $File - $tdiff seconds is > $CRIT"
exit 2
fi

exit 3
