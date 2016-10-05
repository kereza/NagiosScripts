#!/bin/bash

ROC=$(($CURRENT_VAL - $LAST_VAL))

#If the value is less than zero just return 0, this will stop grpahs displaying massive drops which tell us nothing
if [ "$ROC" -le "0" ]; then
	ROC=0
fi

