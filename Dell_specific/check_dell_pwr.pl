#!/usr/bin/perl -w
########################################################
# Power Supply Check by Larry Long - larry@djslyde.com #
# check_pwrsupplies - Check plugin for Nagios          #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;

my($var,$command,@output,$data,@vars,$info);

$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis pwrsupplies|grep 'Main System'`;
foreach $data (@output)
   {
   @vars = split(/\s+/, $data);
   $var = $vars[6];
   chomp $var;
   }

if($var eq 'Ok')
   {
   print "PWR SUPPLY HEALTH: OK  \n";
   exit 0;
   }
elsif($var eq 'Critical')
  {
  print "PWR SUPPLY HEALTH: CRITICAL \n";
  exit 2;
  }
else
  {
  print "PWR SUPPLY HEALTH: WARNING \n";
  exit 1;
  }

