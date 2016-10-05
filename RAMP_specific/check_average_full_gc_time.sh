#!/bin/bash

WARN=$1
CRIT=$2
LOG_FILE=$3

if [ "$3" = "" ]
then
  echo "Too few arguments need 3 - warn crit path_to_log_file"
exit 1
fi

SAMPLE=10

# Return status code of a floating point comparison
float_test() {
  echo | awk 'END { exit ( !( '"$1"')); }'
}


AVERAGE=`grep 'Full GC' $LOG_FILE | tail -$SAMPLE | perl -nle '/real=(\d+\.\d+)/ and $total += $1; $count++; END {$count > 0 and print $total / $count }'`


if [ -z "$AVERAGE" ]; then
    printf "OK - Average time is zero: No Full Garbage Collections have occurred"
    exit 0

elif float_test "$AVERAGE > $CRIT"; then
    printf  "CRTICAL - Average time of the last $SAMPLE Full GCs is $AVERAGE seconds |average_seconds=$AVERAGE,$WARN,$CRIT"
    exit 2

elif float_test "$AVERAGE > $WARN"; then
    printf  "WARNING - Average time of the last $SAMPLE Full GCs is $AVERAGE seconds |average_seconds=$AVERAGE,$WARN,$CRIT"
    exit 1

elif float_test "$AVERAGE <= $WARN"; then
    printf  "OK - Average time of the last $SAMPLE Full GCs is $AVERAGE seconds |average_seconds=$AVERAGE,$WARN,$CRIT"
    exit 0
fi


