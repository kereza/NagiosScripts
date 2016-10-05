#!/bin/sh

NEWDATE=`TZ=GMT+1 date +%Y-%m-%d-%H`

FILETOCHECK="/opt/openbet/logs/fog/rgi/RGI_GameServer.log.${NEWDATE}*"

VAL=`zgrep "Invalid username/password combination" $FILETOCHECK |wc -l`

echo "Number of Failed game at $NEWDATE  $VAL | failrgi=$VAL"

exit 0

