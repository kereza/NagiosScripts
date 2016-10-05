#!/bin/bash

echo "bclcdc1-jeerampbclchandler-01 5445" | \
while read host port; do
  r=$(bash -c 'exec 3<> /dev/tcp/'$host'/'$port';echo $?' 2>/dev/null)
    if [ "$r" = "0" ]; then
        echo $host $port is open
	        exit 0
		  else
		      echo $host $port is closed
		              exit 2
			        fi
				done

