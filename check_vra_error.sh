#!/bin/sh

CRIT=$2

VRA_ERROR=$(tail -n100 /opt/tomcat/logs/vra-service.log | grep -c 'ERROR')

if [ "$VRA_ERROR" -gt 0 ]; then

        echo "CRITICAL, No errors $VRA_ERROR | vra=$VRA_ERROR"

        exit 2

elif [ "$VRA_ERROR" -eq 0 ]; then

        echo "OK, $VRA_ERROR errors | vra=$VRA_ERROR"

        exit 0

fi