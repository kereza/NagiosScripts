#!/bin/bash

STRING="memory.used/max=70"
COUNT=`tail -1000 /opt/tomcat/logs/catalina.out | grep "memory.used/max=70" -c`

if [ "$COUNT" == 0 ]; then
echo "OK: No Errors of type $STRING found|error_count=$COUNT"
exit 0
fi

if [ "$COUNT" > 0 ]; then
echo "CRIT: $COUNT Errors of type $STRING found|error_count=$COUNT"
exit 2
fi

exit 3
