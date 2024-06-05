#!/usr/bin/perl

use warnings;
use strict;

package PW_REGEX_CHECKER;

sub is_password_valid {
    my ($password) = @_;
    if ($password =~ /^
        (?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,11}
        | (?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{12,15}
        | (?=.*[A-Z])(?=.*[a-z]).{16,19}
        | .{20,}
        $/x) {
        return 1;
    }
    return 0;
}
1;
