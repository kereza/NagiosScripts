#!/bin/bash
LINE=`/opt/monitoringScripts/Current/check_procs "$@"`
RC=$?
COUNT=`echo $LINE | awk '{print $3}'`
echo $LINE \| 'num_process'=$COUNT\;$2
exit $RC

