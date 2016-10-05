#!/bin/sh

WARN=$1
CRIT=$2


SOCK_OPEN=`tail -n100 /opt/openbet/logs/monitor/router/router_$(date +%Y%m%d_%H).log |grep chan=sock |sed 's/.*=sock//g' |sort |tail -n1`

if [ "$SOCK_OPEN" -gt 950 ]; then
   echo "CRITICAL, number of sockets in router are $SOCK_OPEN | socket_num=$SOCK_OPEN"
  exit 2
elif [ "$SOCK_OPEN" -gt 600 ]; then
   echo "WARNING, number of sockets in router are $SOCK_OPEN | socket_num=$SOCK_OPEN"
  exit 1
fi

echo "OK, number  of sockets in router are $SOCK_OPEN | socket_num=$SOCK_OPEN"


exit 0

