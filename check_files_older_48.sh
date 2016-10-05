#!/bin/sh
DIR=$1

COUNT=`find $1 -type f -mtime +1 | wc -l`

if [ "$COUNT" -gt 0 ]; then

        echo "CRITICAL, $COUNT files older than 48 hours | files=$COUNT"

	        exit 2

		elif [ "$COUNT" -eq 0 ]; then

		        echo "OK, $COUNT files older than 48 hours | vra=$COUNT"

			        exit 0

				fi
