#!/bin/bash

NUM_LINES=$1

LOG_FILE='/opt/jboss/server/customermatching/log/server.log'

NEW_CUSTOMERS=`tail -10000 $LOG_FILE | grep NumNewCustomers | tail -$NUM_LINES | awk '{ print $14}' | sed -e 's/,$//' | awk '{s+=$1} END {print s}'`


if ((NEW_CUSTOMERS>0))
then
  echo "CUSTMATCH_NEW_CUSTOMERS OK: New customers have been registered during check period|new_customers=$NEW_CUSTOMERS"
exit 0

elif ((NEW_CUSTOMERS<1))
then
  echo "CUSTMATCH_NEW_CUSTOMERS CRIT: No new customers have been registered during check period|new_customers=$NEW_CUSTOMERS"
exit 2

else
  echo "CUSTMATCH_NEW_CUSTOMERS UNKNOWN"
exit 3
fi
