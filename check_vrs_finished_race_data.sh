#!/bin/sh

CRIT=$2

RACE_DATA=$(tail -n100 /opt/local/tomcat/logs/vrs.log | grep -c 'No Finished race data found in the RACE table for RaceId')

if [ "$RACE_DATA" -gt 0 ]; then

        echo "CRITICAL, No Finished race data found for $RACE_DATA races | unfinished_races=$RACE_DATA"

        exit 2

elif [ "$RACE_DATA" -eq 0 ]; then

        echo "OK, $RACE_DATA unfinished race data | unfinished_races=$RACE_DATA"

        exit 0

fi
