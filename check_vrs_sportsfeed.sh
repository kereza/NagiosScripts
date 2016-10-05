#!/bin/sh

CRIT=$2

FREE_SPORTSFEED=$(tail -n100 /opt/local/tomcat/logs/vrs.log | grep -c 'No free SportsFeed available in pool to process')

if [ "$FREE_SPORTSFEED" -gt 0 ]; then

        echo "CRITICAL, No IO Failures is $FREE_SPORTSFEED | feed=$FREE_SPORTSFEED"

        exit 2

elif [ "$FREE_SPORTSFEED" -eq 0 ]; then

        echo "OK, $FREE_SPORTSFEED unfinished race data | feed=$FREE_SPORTSFEED"

        exit 0

fi
