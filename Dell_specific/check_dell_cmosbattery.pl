#!/usr/bin/perl -w
########################################################
# CMOS Battery Check by Larry Long - larry@djslyde.com #
# check_cmosbattery - Check plugin for Nagios          #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;

my($var,$command,@output,$data,@vars,$info);

$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis batteries|grep 'Health'`;
foreach $data (@output)
   {
   @vars = split(/\s+/, $data);
   $var = $vars[2];
   chomp $var;
   }

if($var eq 'Ok')
   {
   print "CMOS BATTERY HEALTH: OK  \n";
   exit 0;
   }
elsif($var eq 'Critical')
  {
  print "CMOS BATTERY HEALTH: CRITICAL \n";
  exit 2;
  }
else
  {
  print "CMOS BATTERY HEALTH: WARNING \n";
  exit 1;
  }

