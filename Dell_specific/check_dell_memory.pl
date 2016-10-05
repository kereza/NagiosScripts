#!/usr/bin/perl -w
########################################################
# Memory Health Check by Larry Long - larry@djslyde.com#
# check_memory - Check plugin for Nagios               #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;

my($var,$command,@output,$data,@vars,$info);

$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis memory|grep 'Health'`;
foreach $data (@output)
   {
   @vars = split(/\s+/, $data);
   $var = $vars[2];
   chomp $var;
   }

if($var eq 'Ok')
   {
   print "MEMORY HEALTH: OK  \n";
   exit 0;
   }
elsif($var eq 'Critical')
  {
  print "MEMORY HEALTH: CRITICAL \n";
  exit 2;
  }
else
  {
  print "MEMORY HEALTH: WARNING \n";
  exit 1;
  }

