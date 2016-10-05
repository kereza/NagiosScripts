#!/bin/bash

LAST_VALS_DIR="ROC_LAST_VALS"

mkdir -p $LAST_VALS_DIR
LAST_VAL_SCRIPT=`basename $THIS_SCRIPT .sh`
LAST_VAL_SCRIPT="${LAST_VALS_DIR}/${LAST_VAL_SCRIPT}_last_val-${VAL_TYPE}.sh"

if [ -e "$LAST_VAL_SCRIPT" ]
then
        . "${LAST_VAL_SCRIPT}"
else
        LAST_VAL=0
fi

