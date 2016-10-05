#!/bin/sh
OBJECT=$1
ATTRIBUTE=$2
EXTRAS=$3

JMX_ENDPOINT="service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi"
USERNAME="guest"
PASSWORD="Guest"

VALUE=`/opt/monitoringScripts/Current/diffusion/check_jmx -U $JMX_ENDPOINT -username $USERNAME -password $PASSWORD -O $OBJECT -A $ATTRIBUTE $EXTRAS|cut -d '=' -f3`


if [ "$VALUE" -gt 20 ]; then

        echo "OK, number of connections $VALUE | VALUE=$VALUE"

        exit 0

elif [ "$VALUE" -lt 20 ]; then

        echo "Critical, number of connections too low $VALUE | VALUE=$VALUE"

        exit 2

fi

