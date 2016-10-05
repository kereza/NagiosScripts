#!/bin/sh

LINE_COUNT=$(wc -l /opt/apache/htdocs/logs/alarms/silkfile.txt | awk '{print $1}')

if [ "$LINE_COUNT" -gt 1 ]; then

        echo "CRITICAL Silks not received linecount: $LINE_COUNT  | errors=$LINE_COUNT"

	        exit 2



		elif [ "$LINE_COUNT" -eq 0 ]; then

		        echo "OK, Silks received linecount is:  $LINE_COUNT | errors=$LINE_COUNT"

			        exit 0

				fi

