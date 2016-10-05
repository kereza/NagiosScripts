#!/bin/sh

WARN=$1
CRIT=$2


CAPACITY=`grep -c 'Not enough capacity for win selections' /opt/openbet/logs/node_settler/settler_$(date +%Y%m%d_%H).log`

if [ "$CAPACITY" -gt 100 ]; then
   echo "CRITICAL, $CAPACITY capacity errors | capacity_errors=$CAPACITY"
     exit 2
     elif [ "$CAPACITY" -gt 50 ]; then
        echo "WARNING, $CAPACITY capacity errors | capacity_errors=$CAPACITY"
	  exit 1
	  fi

	  echo "OK, $CAPACITY capacity errors | capacity_errors=$CAPACITY"


	  exit 0
