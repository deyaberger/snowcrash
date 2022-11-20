#!/usr/bin/env perl

sub t {
  $nn = $_[1];
  print "\$nn: $nn\n";
  $xx = $_[0];
  print "\$xx: $xx\n";
  $xx =~ tr/a-z/A-Z/; 
  print "\$xx: $xx\n";
  $xx =~ s/\s.*//;
  print "\$xx: $xx\n";
  $command = "egrep \"^$xx\" /tmp/xd\n";
  print "command: $command";
  @output = `egrep "^$xx" /tmp/xd`;
  # @output = `egrep "^$xx" /tmp/xd 2>&1`;
  print "output: @output\n";
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  $a = $_[0];
  print "\$_[0]: $a";
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }    
}

%param = ('x' => '$lol', 'y' => 'lal');
print "X: $param{'x'}\n";
print "Y: $param{'y'}\n";

n(t($param{'x'}, $param{'y'}));
