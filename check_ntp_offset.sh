#!/bin/sh

WARN=$1
CRIT=$2
#CRIT==$(echo "scale=7;$2" | bc)
NTP_HOST=$3









if [ "$3" = "" ]; then
echo "Too few arguments need 3 - warn crit jboss_host app_name"
exit 1
fi

OFFSET2=`/usr/sbin/ntpdate -q $3| tail -n1 | awk '{ print $10}'`
OFFSET=$(echo "scale=7;$OFFSET2"| bc | sed 's/-//')


#OFFSET=$(echo "scale=7;$OFFSET2 * -1"| bc)

function f_AgtB()
{
        a=$1
        b=$2
        if [ "${a}" != "" -a "${b}" != "" ]
        then
                len_a=${#a}
                len_b=${#b}

                if [ $len_a -gt $len_b ]
                then
                        b=${b}`f_add_zeros $(( $len_a - $len_b ))`
                else
                        a=${a}`f_add_zeros $(( $len_b - $len_a ))`
                fi

                a=`echo $a | sed 's/\.//'`
                b=`echo $b | sed 's/\.//'`

                if [ $a -gt $b ]
                then
                        echo 1
                else
                        echo 0
                fi
        fi
}


function f_add_zeros()
{
        i=0
        while [ $i -lt $1 ]
        do
                out=${out}0
                ((i++))
        done
        echo $out
}

#echo "$OFFSET"
#echo "$WARN"
#echo "$CRIT"

if [ `f_AgtB $OFFSET $WARN` == 0 ]; then
#if [ "$OFFSET" -le "$WARN"]; then
echo "OK: Offset less than $1 |offset=$OFFSET;$WARN;$CRIT"
exit 0
fi

#if [ "$OFFSET" -le "$CRIT" ]; then
if [ `f_AgtB $OFFSET $CRIT` == 0 ]; then
echo "WARN: Offset $OFFSET which exceeds $WARN|offset=$OFFSET;$WARN;$CRIT"
exit 1
fi

if [ `f_AgtB $OFFSET $WARN` == 1 ]; then
#if [ "$OFFSET" -ge "$CRIT" ]; then
echo "CRIT: Offset $OFFSET which exceeds $CRIT|offset=$OFFSET;$WARN;$CRIT"
exit 2
fi
exit 3

