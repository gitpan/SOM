#!/usr/bin/perl
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..30\n"; }
END {print "not ok 1\n" unless $loaded;}

use SOM ':types', ':class', ':dsom', ':environment';

$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$daemonUp = IsSOMDDReady();
print "ok 2 # Daemon running = $daemonUp\n";

RestartSOMDD(1) or die "Could not restart SOMDD: $^E" unless $daemonUp;
print "ok 3\n";

$serverUp = IsWPDServerReady();
print "ok 4 # Server running = $serverUp\n";

RestartWPDServer(1) or die "Could not restart WPDServer: $^E" unless $serverUp;
print "ok 5\n";

$ev = SOM::CreateLocalEnvironment();
print "not " unless $ev;
print "ok 6\n";

SOM::SOMDeamon::Init($ev);
print "ok 7\n";

sub EnvironmentPtr::CheckAndWarn {
  my $err; $err = $ev->Check and warn "Got exception $err";
  !$err
}

$ev->CheckAndWarn or print "not ";
print "ok 8\n";

$SOM_ClassMgr = SOM::SOMDeamon::ClassMgrObject() or print "not ";
print "ok 9\n";
$WPS_ClassMgr = SOM::SOMDeamon::WPClassManagerNew() or print "not ";
print "ok 10\n";

$SOM_ClassMgr->MergeInto($WPS_ClassMgr); # In fact opposite direction
print "ok 11\n";

Init_WP_Classes();		# Otherwise cannot GetClassObj('WPFolder')
print "ok 12\n";

$server = SOM::SOMDeamon::ObjectMgr->FindServerByName($ev, "wpdServer")
  or print "not ";
print "ok 13\n";

$ev->CheckAndWarn or print "not ";
print "ok 14\n";

$classFolder = $classFolder = $server->GetClassObj($ev, "WPFolder")
  or print "not ";
print "ok 15\n";

$ev->CheckAndWarn or print "not ";
print "ok 16\n";

print "ok $_\n" for 17..22;

sleep 2;			# Otherwise Server would not yet start?

SOM::SOMDeamon::ObjectMgr->ReleaseObject($ev, $server);
print "ok 23\n";

$ev->CheckAndWarn or print "not ";
print "ok 24\n";

SOM::SOMDeamon::Uninit($ev);
print "ok 25\n";

$ev->CheckAndWarn or print "not ";
print "ok 26\n";

RestartWPDServer(0) or print "# Could not shutdown WPDServer: $^E\nnot "
  unless $serverUp;
print "ok 27\n";

if (not $daemonUp) {
  my $c = 30;
  my $ok = 1;

  sleep 1 while --$c>0 and IsWPDServerReady();
  print "ok 28\n";
  $ok = 0, warn "Could not wait for shutdown of WPDServer!\n" if $c <= 0;
  RestartSOMDD(0) or $ok = 0, warn "Could not shutdown SOMDD: $^E";
  print "ok 29\n";
  $ok or print "not ";
} else {
  print "ok 28\n";
  print "ok 29\n";
}
print "ok 30\n";


