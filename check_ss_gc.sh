#!/bin/sh


logfile="/opt/openbet/logs/site_management/run_process_siteserver_core.log.$(date +%Y%m%d) /opt/openbet/logs/site_management/run_process_siteserver_oxirepclient.log.$(date +%Y%m%d) /opt/openbet/logs/site_management/run_process_siteser
ver_oxirepclient.log.$(date +%Y%m)%d"
WARN=0.7
CRIT=0.9
WALM=0
CALM=0
for time in `tail $logfile |grep GC|sed 's/.*real=//' |cut -d' ' -f1`
do
  if (( $(echo "$WARN < $time" | bc -l) )); then WALM=1; fi;
    if (( $(echo "$CRIT < $time" | bc -l) )); then CALM=1; fi;

    done

    if [ $CALM != 0 ]; then
    echo "CRITICAL, siteserver  GC collection is taking more than > $time | time=$time"
    exit 2
    fi

    if [ $WALM != 0 ]; then
    echo "WARNING, siteserver  GC collection is taking more than > $time | time=$time"
    exit 1
    fi

    echo "OK, siteserver GC is working fine | time=$time"
    exit 0

