#!/usr/bin/perl

use strict;
use warnings;
require "./password_checker.pl";

print "Input your password\n";
my $pw = <STDIN>;
if(CHECK_PW::check_password($pw)){
    print "Valid password!", "\n";
}
