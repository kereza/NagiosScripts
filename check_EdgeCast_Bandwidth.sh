#!/bin/sh
WARN=$1
CRIT=$2

ecast_bwidth=`wget -O- --no-check-certificate --quiet --header "Authorization: TOK:e034fba5-7c45-4fcd-a018-752eb1229203" https://api.edgecast.com/v2/realtimestats/customers/6ADC/media/3/bandwidth | tr -d "{}\"[]" | cut -d ':' -f2 | cut -d '.' -f1`

((Bandwidth=ecast_bwidth/131072))
#((Bandwidth=$Bandwidth/1024))
#echo $Bandwidth

if [ "$Bandwidth" -ge "$WARN" ]; then
echo "OK: EdgeCast Bandwidth Utilization is $Bandwidth|Mbps=$Bandwidth;$WARN;$CRIT"
exit 0
fi

if [ "$Bandwidth" -le "$WARN" -a "$Bandwidth" -ge "$CRIT" ] ;then
echo "WARN: EdgeCast Bandwidth Utilization is below $WARN Mbps at $Bandwidth Mpbs|Mbps=$Bandwidth;$WARN;$CRIT"
exit 1
fi

if [ "$Bandwidth" -le "$CRIT" ] ;then
echo "CRIT: EdgeCast Bandwidth Utilization is below $CRIT Mbps at $Bandwidth Mpbs|Mbps=$Bandwidth;$WARN;$CRIT"
exit 2
fi

