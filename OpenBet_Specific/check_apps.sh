#!/bin/sh
#set -x
TELEBET="0";
FREEBETS="0";
OXIREP="0";
DBV="0";
MONEYBOOKERS="0";
OXIPUB="0";
IPN_PROCESSOR="0";
ADMIN="0";
CUSTCOM_ML="0";
RACING="0";
FOOTBALL="0";
BETSLIP="0";
VIDEO="0";
MY_ACCOUNT="0";
OXIXML="0";
MONEY="0";
OXIRGS="0";
WAP="0";
BOSSMEDIA="0";
RESULT="";
TIME=`date +"%H:%M"`;
HOUR=`date +"%m_%d_%H"`;
WARN=75
CRIT=85
for i in `ps -ef|grep -s openbet|grep -s run_appserv|grep -s -v "grep -s"|awk '{FS="-c";print $2}'|cut -d" " -f2|sed -e s'/-x86-64.cfg//' -e s'/_groups.cfg//' -e s'/.cfg//'|sort|uniq|grep -s [a-z]`;
do
case ${i} in

    telebet/server )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/server/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            TELEBET=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/server/*${HOUR}*log ];then
            TELEBET="1";
        fi;;

    server )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/server/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'| sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            TELEBET=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/server/*${HOUR}*log ];then
            TELEBET="1";
        fi;;

    freebets_server )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            FREEBETS=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            FREEBETS="1";
        fi;;

    oxi/oxirepserver/server )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/oxi/oxirepserver/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            OXIREP=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/oxi/oxirepserver/*${HOUR}*log ];then
            OXIREP="1";
        fi;;

    dbv )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            DBV=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            DBV="1";
        fi;;

    moneybookers )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            MONEYBOOKERS=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            MONEYBOOKERS="1";
        fi;;

    oxi/oxipubserver )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            OXIPUB=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            OXIPUB="1";
        fi;;

    paypal/ipn_processor )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/ipn_processor/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            IPN_PROCESSOR=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/ipn_processor/*${HOUR}*log ];then
            IPN_PROCESSOR="1";
        fi;;

    admin )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            ADMIN=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            ADMIN="1";
        fi;;

    custcom_ml )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            CUSTCOM_ML=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            CUSTCOM_ML="1";
        fi;;

    custcom_ml_racing )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            RACING=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            RACING="1";
        fi;;

    custcom_ml_football )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            FOOTBALL=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            FOOTBALL="1";
        fi;;

    custcom_ml_betslip )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            BETSLIP=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            BETSLIP="1";
        fi;;

    custcom_ml_video )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            VIDEO=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            VIDEO="1";
        fi;;

    custcom_ml_my_account )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            MY_ACCOUNT=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            MY_ACCOUNT="1";
        fi;;

    oxixmlserver )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/oxi/oxixmlserver/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            OXIXML=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/oxi/oxixmlserver/*${HOUR}*log ];then
            OXIXML="1";
        fi;;

    money_ml )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            MONEY=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            MONEY="1";
        fi;;

    oxi/oxirgsserver )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/${i}/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            OXIRGS=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/${i}/*${HOUR}*log ];then
            OXIRGS="1";
        fi;;

    wap )
        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/mobile/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'|sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            WAP=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/mobile/*${HOUR}*log ];then
            WAP="1";
        fi;;

    bossmedia )

        MAXPROC=`grep -s "${TIME}" /opt/openbet/logs/bossmedia/*${HOUR}*log|grep -s "AS::REQ::BEGIN"|awk '{FS=" ";print $NF}'|sort -n |uniq|sed -e 's/(//' -e 's/)//'| sort -n|tail -1`;
        if  [ "${MAXPROC}" != "" ]; then
            num=`echo "${MAXPROC}"|cut -d"/" -f1`
            den=`echo "${MAXPROC}"|cut -d"/" -f2`
            BOSSMEDIA=`echo $num $den|awk '{printf("%f\n", $1/$2*100) }' |cut -d"." -f1`;
        elif [ -f /opt/openbet/logs/bossmedia/*${HOUR}*log ]; then
            BOSSMEDIA="1";
        fi;;

esac

done

for i in TELEBET FREEBETS OXIREP DBV MONEYBOOKERS OXIPUB ADMIN CUSTCOM_ML RACING FOOTBALL BETSLIP VIDEO MY_ACCOUNT OXIXML MONEY OXIRGS WAP BOSSMEDIA; do
eval PERC=\${${i}}
if [ "${PERC}" != "0" ]; then
    RESULT="${RESULT}${i}=${PERC},\n"
fi
done
RESULT="${RESULT}|"
for i in TELEBET FREEBETS OXIREP DBV MONEYBOOKERS OXIPUB ADMIN CUSTCOM_ML RACING FOOTBALL BETSLIP VIDEO MY_ACCOUNT OXIXML MONEY OXIRGS WAP BOSSMEDIA; do
eval PERC=\${${i}}
if [ "${PERC}" != "0" ]; then
    RESULT="${RESULT}${i}=${PERC}%;$WARN;$CRIT;0;100,\n"
fi
done
echo  -e ${RESULT} |sed s'/-e //';
