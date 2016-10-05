#!/bin/sh

CRIT=$2

GEOIP_ERROR=$(tail -n100  /opt/versions/GeoDirectory*/GeoDirectory700*/log/quovaserver.log | grep -c 'ERROR - Caught exception')

if [ "$GEOIP_ERROR" -gt 0 ]; then

        echo "CRITICAL, No of Crtical errors is errors is $GEOIP_ERROR | quova=$GEOIP_ERROR"

	        exit 2

		elif [ "$GEOIP_ERROR" -eq 0 ]; then

		        echo "OK, $GEOIP_ERROR Quova errors | quova=$GEOIP_ERROR"

			        exit 0

				fi
