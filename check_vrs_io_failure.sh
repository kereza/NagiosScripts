#!/bin/sh

CRIT=$2

IO_FAILURE=$(tail -n100 /opt/local/tomcat/logs/vrs.log | grep -c 'IOFailure from server')

if [ "$IO_FAILURE" -gt 0 ]; then

        echo "CRITICAL, No IO Failures is $IO_FAILURE | io_failure=$IO_FAILURE"

        exit 2

elif [ "$IO_FAILURE" -eq 0 ]; then

        echo "OK, $IO_FAILURE unfinished race data | io_failure=$IO_FAILURE"

        exit 0

fi
