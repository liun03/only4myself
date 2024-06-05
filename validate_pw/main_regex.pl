#!/usr/bin/perl

use strict;
use warnings;
require "./pw_regex.pl";

print "Input your password\n";
my $pw = <STDIN>;
if(PW_REGEX_CHECKER::is_password_valid($pw)){
    print "Valid password!", "\n";
} else {
    print "InValid password!", "\n";
}
