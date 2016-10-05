#!/usr/bin/perl -w
########################################################
# Chassis Temp Check by Larry Long - larry@djslyde.com #
# check_temp - Check plugin for Nagios                 #
# 2-18-2008 : Requires Dell Open Manage                #
########################################################
use strict;
use Getopt::Std;

my($command,$index,$warn,$crit,$var,@output,$temp,@vars,$info);

### Run 'omreport chassis temps' to find the probe you
### want to monitor. I typically use "System Temp"

sub info
   {
   my $info = "Usage: $0 -p <probe> -w <warning> -c <critical>\n";
   die $info;
   exit 2;
   }

my %opt;getopts('hp:w:c:', \%opt);
info() unless defined $opt{w};
info() if exists $opt{h};

$index = "0";
$index = $opt{p} if exists $opt{p};
$warn = $opt{w};
$crit = $opt{c};
$var = 0;
$command = "/opt/dell/srvadmin/bin/omreport";

@output = `$command chassis temps index=$index|grep 'Reading'`;
foreach $temp (@output)
   {
   @vars = split(/\s+/, $temp);
   $var = $vars[2];
   chomp $var;
   }

if($var < $warn)
   {
   print "TEMP OK - $var C \n";
   exit 0;
   }
elsif($var >= $crit)
  {
  print "TEMP CRITICAL - $var C \n";
  exit 2;
  }
else
  {
  print "TEMP WARNING - $var C \n";
  exit 1;
  }

