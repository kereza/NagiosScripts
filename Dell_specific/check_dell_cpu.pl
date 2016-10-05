#!/usr/bin/perl -w
########################################################
# CPU Health Check by Larry Long - larry@djslyde.com   #
# check_cpu - Check plugin for Nagios                  #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;

my($var,$command,@output,$data,@vars,$info);

$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis processors|grep 'Health'`;
foreach $data (@output)
   {
   @vars = split(/\s+/, $data);
   $var = $vars[2];
   chomp $var;
   }

if($var eq 'Ok')
   {
   print "CPU HEALTH: OK  \n";
   exit 0;
   }
elsif($var eq 'Critical')
  {
  print "CPU HEALTH: CRITICAL \n";
  exit 2;
  }
else
  {
  print "CPU HEALTH: WARNING \n";
  exit 1;
  }

