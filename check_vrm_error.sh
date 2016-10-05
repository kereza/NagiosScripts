#!/bin/sh

CRIT=$2

VRM_ERROR=$(tail -n100 /opt/tomcat/logs/vr-media-streamer.log | grep -c 'ERROR')

if [ "$VRM_ERROR" -gt 0 ]; then

        echo "CRITICAL, No of vrm errors is $VRM_ERROR | vrm=$VRM_ERROR"

        exit 2

elif [ "$VRM_ERROR" -eq 0 ]; then

        echo "OK, $VRM_ERROR vrm errors | vrm=$VRM_ERROR"

        exit 0

fi
