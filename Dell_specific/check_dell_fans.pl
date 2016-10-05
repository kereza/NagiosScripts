#!/usr/bin/perl -w
########################################################
# Chassis Fans Check by Larry Long - larry@djslyde.com #
# check_fans - Check plugin for Nagios                 #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;

my($var,$command,@output,$data,@vars,$info);

$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis fans|grep 'Chassis Fans'`;
foreach $data (@output)
   {
   @vars = split(/\s+/, $data);
   $var = $vars[4];
   chomp $var;
   }

if($var eq 'Ok')
   {
   print "CHASSIS FANS: OK  \n";
   exit 0;
   }
elsif($var eq 'Critical')
  {
  print "CHASSIS FANS: CRITICAL \n";
  exit 2;
  }
else
  {
  print "CHASSIS FANS: WARNING \n";
  exit 1;
  }

