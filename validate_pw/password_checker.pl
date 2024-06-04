#!/usr/bin/perl

use warnings;
use strict;

package CHECK_PW;

sub check_mixed_cases {
    my ($password) = @_;
    if($password =~ /[a-z]/ && $password =~ /[A-Z]/) {
        return 1;
    }
    return 0;
}

sub check_numbers {
    my ($password) = @_;
    if ($password =~ /[0-9]/) {
        return 1;
    }
    return 0;
}

sub check_symbols {
    my ($password) = @_;
    if ($password =~ /[\W_]/) {
        return 1;
    }
    return 0;
}

sub check_password {
    my ($password) = @_;
    my $password_length = length($password);
    if($password_length >= 20) {
        return 1;
    } elsif ($password_length >= 16) {
        if (check_mixed_cases($password)) {
            return 1;
        } else {
            print "requires mixed case letters", "\n";
        }
    } elsif ($password_length >= 12) {
        if (check_mixed_cases($password) && check_numbers($password)) {
            return 1;
        } else {
            print "requires mixed case letters and numbers", "\n";
        }
    } elsif ($password_length >= 8) {
        if (check_mixed_cases($password) && check_numbers($password) && check_symbols($password)) {
            return 1;
        } else {
            print "requires mixed case letters, numbers and symbols", "\n";
        }
    } else {
        print "Password must be at least 8 characters long", "\n";
    }
    return 0;
}
1;
