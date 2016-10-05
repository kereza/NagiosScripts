#!/bin/bash
NUMTOTOXIMSG=`grep "SiteServer's lastOXiMsgId: " /opt/openbet/logs/siteserver/oxirepclient.log |tail -30 |awk '{print $9}'  |wc -l`
NUMOXIMSG=`grep "SiteServer's lastOXiMsgId: " /opt/openbet/logs/siteserver/oxirepclient.log |tail -30 |awk '{print $9}' |sort -u |wc -l`


if [ "$NUMOXIMSG" -eq 1 ] && [ "$NUMTOTOXIMSG" -gt 10 ]; then
   echo "SiteServer oxirepclient stuck on the same oximsg"
      # Exit 2 so exit with CRITICAL
         exit 2
	 else
	    echo "Siteserver oxirepclient OK"
	       exit 0
	       fi

