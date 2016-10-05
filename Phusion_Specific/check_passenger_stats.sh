#!/bin/sh

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
#   Author: Joel Parker Henderson (joel@sixarm.com, http://sixarm.com)
#   Updated: 2010-11-19
#
#   This program is based on code from check_nginx.sh
#   created by Mike Adolphs (http://www.matejunkie.com/)
#
#   We use this script to do Nagios monitoring on our web servers
#   that are running Ruby On Rails, Apache and Phusion Passenger.
# 
#   For more info on Passenger & Nagios:
#   Phusion Passenger: http://phusion.nl
#   Nagios monitoring: http://www.nagios.org   
#   Nagios graph tool: http://nagiosgraph.sourceforge.net/
#
#   We use this script for gathering memory stats info which we
#   display using Nagios Graph overlaid with other Nagios stats,
#   so this script always outputs "OK" rather than any alerts.
#
#   If you want to use the critical alert features of Nagios, 
#   then you can modify this script to return different output
#   depending on whatever values that you feel are best for
#   your own server, available RAM, and Passenger settings.
#   If you need help with this, feel free to contact me.

PROGNAME=`basename $0`
VERSION="Version 1.2.0,"
AUTHOR="2010, Joel Parker Henderson (joel@sixarm.com, http://sixarm.com/)"

ST_OK=0
ST_WR=1
ST_CR=2
ST_UK=3

print_version() {
    echo "$VERSION $AUTHOR"
}

print_help() {
    print_version $PROGNAME $VERSION
    echo ""
    echo "$PROGNAME is a Nagios plugin to check passenger memory stats,"
    echo "specifically for Passenger processes Rails VMSize sum."
    echo ""
    exit $ST_UK
}

while test -n "$1"; do
    case "$1" in
        -help|-h)
            print_help
            exit $ST_UK
            ;;
        --version|-v)
            print_version $PROGNAME $VERSION
            exit $ST_UK
            ;;
        *)
            echo "Unknown argument: $1"
            print_help
            exit $ST_UK
            ;;
        esac
    shift
done


get_vals() {
   passenger_memory_stats_passenger_processes_rails_vmsize_sum=`passenger-memory-stats | sed -n '/^-* Passenger processes -*$/,/^$/p' | grep "Rails: " | awk '{ sum += $2 }; END { print sum }'`
}

do_output() {
    output="$passenger_memory_stats_passenger_processes_rails_vmsize_sum passenger memory stats passenger processes rails vmsize sum"
}

do_perfdata() {
    perfdata="'pms_p_vm_sum'=$passenger_memory_stats_passenger_processes_rails_vmsize_sum"
}

# Here we go!
get_vals
do_output
do_perfdata

echo "OK - ${output} | ${perfdata}"
exit $ST_OK


