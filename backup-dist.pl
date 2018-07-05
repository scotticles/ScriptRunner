#!/usr/bin/perl

use warnings;
use strict;
use Net::Pushover;
use Try::Tiny;
use Sys::Hostname;
use Getopt::Long;

my $host = hostname;

my $binary;
my $script;
my $pToken = "";
my $pUserToken = "";
my $pTitle = 'Backup script';
my $disablePushover = 0;
GetOptions ('b=s' => \$binary, 's=s' => \$script, 'pToken' => \$pToken, 'pUserToken' => \$pUserToken, 'pTitle' => \$pTitle, 'pDisable' => \$disablePushover);
if(!$binary || !$script)
{
  die "./backup
        -b /path/to/binary (required)
        -s /path/to/script (required)
        -pToken <Pushover Token>
        -pUserToken <Pushover User Token>
        -pTitle <message|Backup script on host failed!>
        -pDisable 1 Will turn off pushover if set to 1\n";
}


try {
  my $output = `$binary $script 2>&1 1>/dev/null`;
  if($output)
  {
    die $output;
  }
} catch {

  if(!$disablePushover)
  {
    # new object with auth parameters
    my $push = Net::Pushover->new(
      token => $pToken,
      user => $pUserToken
    );

    # send a notification
    $push->message( 
      title => "$pTitle on $host failed!", 
      text => "caught error: $_",
      timestamp => "date +%s"
    );
  }
    die "caught error: $_"; # not $@
};