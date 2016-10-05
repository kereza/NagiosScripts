#!/bin/sh
OBJECT=$1
ATTRIBUTE=$2
EXTRAS=$3

JMX_ENDPOINT="service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi"
USERNAME="guest"
PASSWORD="Guest"

VALUE=`/opt/monitoringScripts/Current/diffusion/check_jmx -U $JMX_ENDPOINT -username $USERNAME -password $PASSWORD -O $OBJECT -A $ATTRIBUTE $EXTRAS` 

echo $VALUE

