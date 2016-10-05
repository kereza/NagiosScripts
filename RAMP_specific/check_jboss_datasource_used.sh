#!/bin/bash
WARN=$1
CRIT=$2
JBOSS_HOST=$3
DS_NAME=$4
if [ "$4" = "" ]; then
echo "Too few arguments need 4 - warn crit jboss_host datasource_name"
exit 1
fi

MAX_DS_USED=0


TOTAL_DS_STRING=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get "jboss.jca:service=ManagedConnectionPool,name=${DS_NAME}" MaxSize`

#
# Check that it a valid datasource name was provided
#

if [ $? != 0 ]; then
    echo "WARN: Datasource $DS_NAME is not registered"
    exit 1
fi

TOTAL_DS=`echo $TOTAL_DS_STRING | awk -F= '{print $2}'`


for i in {1..10}
do
  CURRENT_DS_USED=`/opt/jboss/bin/twiddle.sh -s $JBOSS_HOST get "jboss.jca:service=ManagedConnectionPool,name=${DS_NAME}" InUseConnectionCount|awk -F= '{print $2}'`
  sleep 1
  if ((CURRENT_DS_USED>MAX_DS_USED))
  then
    MAX_DS_USED=$CURRENT_DS_USED
  fi
done




USED_PCT_TOTAL=`echo "$MAX_DS_USED $TOTAL_DS" | awk '{ print $1 / $2*100}'`
USED_PCT=`echo $USED_PCT_TOTAL|awk -F. '{print $1}'`

if ((USED_PCT<=WARN)); then
        echo "OK: Datasource $DS_NAME connections used is $USED_PCT% ($MAX_DS_USED of $TOTAL_DS) |dscon=$USED_PCT%;$WARN;$CRIT;0;100"
exit 0
fi

if ((USED_PCT<=CRIT)); then
        echo "WARN: Datasource $DS_NAME connections used is $USED_PCT% ($MAX_DS_USED of $TOTAL_DS) which is above $WARN |dscon=$USED_PCT%;$WARN;$CRIT;0;100"
exit 1
fi

if ((USED_PCT>=CRIT)); then
        echo "CRIT: Datasource $DS_NAME connections used is $USED_PCT% ($MAX_DS_USED of $TOTAL_DS) which is above $CRIT|dscon=$USED_PCT%;$WARN;$CRIT;0;100"
exit 2
fi
exit 3
