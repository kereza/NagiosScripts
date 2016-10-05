#!/bin/bash

LOGFILE=/var/log/puppet/masterhttp.log
TMPFILE=/tmp/check_puppet.nagios

HOSTS_COUNT=`grep HOST /etc/puppet/manifests/nodes.pp  | wc -l`
CA_COUNT=`/usr/sbin/puppetca --list  | wc -l`

if [ ! -f $TMPFILE ]; then
        ACTIVE_COUNT=`cat ${LOGFILE} | awk '{print $3}' | grep ^10 | sort | uniq | wc -l`
        echo $ACTIVE_COUNT > $TMPFILE
elif test `find $TMPFILE -mmin +5`; then
        ACTIVE_COUNT=`cat ${LOGFILE} | awk '{print $3}' | grep ^10 | sort | uniq | wc -l`
        echo $ACTIVE_COUNT > $TMPFILE
else 
        ACTIVE_COUNT=`cat $TMPFILE`
fi

echo "Hosts in Puppet" \| 'hosts'=$HOSTS_COUNT\; 'ca_wait'=$CA_COUNT\; 'hosts_active'=$ACTIVE_COUNT\;
