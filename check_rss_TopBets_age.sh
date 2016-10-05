#!/bin/sh
WARN=$3
CRIT=$4

RSSDate=`wget -qO- $1 | grep "<channel>" -A5 | grep $2 | sed -n -e 's/.*<pubDate>\(.*\)<\/pubDate>.*/\1/p'`
D1=`date +%s -d "$RSSDate"`
D2=`date +%s`
((diff_sec=D2-D1))
#echo - | awk '{printf "%d:%d:%d","'"$diff_sec"'"/(60*60),"'"$diff_sec"'"%(60*60)/60,"'"$diff_sec"'"%60}'


if [ "$diff_sec" -le "$WARN" ]; then
echo "OK: Page is only $diff_sec seconds old|age=$diff_sec;$WARN;$CRIT"
exit 0
fi

if [ "$diff_sec" -ge "$WARN" -a "$diff_sec" -le "$CRIT" ];then
echo "WARN: Page is $diff_sec seconds old|age=$diff_sec;$WARN;$CRIT"

exit 1
fi

if [ "$diff_sec" -ge "$CRIT" ];then
echo "CRIT: Page is $diff_sec seconds old|age=$diff_sec;$WARN;$CRIT" 
exit 2
fi

