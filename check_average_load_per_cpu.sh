#!/bin/bash

WARN=$1
CRIT=$2

if [ -z $2 ]; then
  echo "calulate the average load per CPU"
  echo "2 parameters (warn crit) necessary.  Both should be a decimal <=1.0 (e.g. 0.8 0.95)"
  exit 3
fi

# trying to avoid extra processes, especially if there is a high load
# so trying to avoid using awk and grep in these next lines
load_array=(`cat /proc/loadavg`)
while read line; do if [[ $line =~ processor.* ]]; then num_cpu=$(( num_cpu + 1 )); fi; done < /proc/cpuinfo

# unfortunately we still need to use bc for anything to do with floating point numbers.
# Calculate average load per CPU, which is the load average divided by the number of CPUs

# uncommnet one of the below, depending on what you want:
# 1 minute load average
# load=$( echo "scale=3; ${load_array[0]}/$num_cpu" | bc -l )

# 5 minute load average
load=$( echo "scale=3; ${load_array[1]}/$num_cpu" | bc -l )

# 15 minute load average
# load=$( echo "scale=3; ${load_array[2]}/$num_cpu" | bc -l )


if (( $(echo "$load < $WARN" | bc -l) )); then
  echo "OK: Average load per CPU (5 min) is $load|load=$load;$WARN;$CRIT"
  exit 0
elif (( $(echo "$load < $CRIT" | bc -l) )); then
  echo "WARN: Average load per CPU (5 min) is $load|load=$load;$WARN;$CRIT"
  exit 1
else
  echo "CRIT: Average load per CPU (5 min) is $load|load=$load;$WARN;$CRIT"
  exit 2
fi

