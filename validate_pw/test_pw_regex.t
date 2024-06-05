#!/usr/bin/perl

use Test::Simple tests => 28;
use strict;
use warnings;
require "./pw_regex.pl";

# Test for invalid password length
ok(!PW_REGEX_CHECKER::is_password_valid("short"), 'Password "short" is too short');
ok(!PW_REGEX_CHECKER::is_password_valid("1lSac!^"), 'Password "1lSac!^" is too short');
ok(!PW_REGEX_CHECKER::is_password_valid("seven7!"), 'Password "seven7!" is too short');

# Test for valid and invalid 8-11 character passwords
ok(PW_REGEX_CHECKER::is_password_valid("Ab1!abcd"), 'Password "Ab1!abcd" is valid (8-11 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("Abc!abcd"), 'Password "Abc!abcd" is invalid (8-11 chars, missing digit)');
ok(!PW_REGEX_CHECKER::is_password_valid("Ab1abcd"), 'Password "Ab1abcd" is invalid (8-11 chars, missing symbol)');
ok(PW_REGEX_CHECKER::is_password_valid("A1!aB2\@c"), 'Password "A1!aB2@c" is valid (8-11 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("12345678"), 'Password "12345678" is invalid (8-11 chars, missing letters and symbol)');

# Test for valid and invalid 12-15 character passwords
ok(PW_REGEX_CHECKER::is_password_valid("Ab1abcdefabcdef"), 'Password "Ab1abcdefabcdef" is valid (12-15 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("Abcdefabcdef"), 'Password "Abcdefabcdef" is invalid (12-15 chars, missing digit)');
ok(!PW_REGEX_CHECKER::is_password_valid("ababcdefabcde"), 'Password "ababcdefabcde" is invalid (12-15 chars, only lowercase)');
ok(!PW_REGEX_CHECKER::is_password_valid("ABCDEFGHIJKL"), 'Password "ABCDEFGHIJKL" is invalid (12-15 chars, only lowercase)');
ok(PW_REGEX_CHECKER::is_password_valid("A1bcdefghijklm"), 'Password "A1bcdefghijklm" is valid (12-15 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("abcdefghijklm1"), 'Password "abcdefghijklm1" is invalid (12-15 chars, missing uppercase)');

# Test for valid and invalid 16-19 character passwords
ok(PW_REGEX_CHECKER::is_password_valid("Abcdefghijklmnop"), 'Password "Abcdefghijklmnop" is valid (16-19 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("abcdefghijklmno"), 'Password "abcdefghijklmno" is invalid (16-19 chars, missing uppercase)');
ok(!PW_REGEX_CHECKER::is_password_valid("1234567890123456"), 'Password "1234567890123456" is invalid (16-19 chars, missing mixed case)');
ok(!PW_REGEX_CHECKER::is_password_valid("~!\@#\$%^&*()<>:][]"), 'Password "~!@#$%^&*()<>:][]" is invalid (16-19 chars, missing mixed case)');
ok(!PW_REGEX_CHECKER::is_password_valid("ABCDEFGHIJKLMNOP"), 'Password "ABCDEFGHIJKLMNOP" is invalid (16-19 chars, missing lowercase)');
ok(!PW_REGEX_CHECKER::is_password_valid("ABCDEFGHIJKLMNO!"), 'Password "ABCDEFGHIJKLMNO!" is invalid (16-19 chars, missing lowercase)');
ok(!PW_REGEX_CHECKER::is_password_valid("ABCDEFGHIJKLMNO1"), 'Password "ABCDEFGHIJKLMNO1" is invalid (16-19 chars, missing lowercase)');
ok(PW_REGEX_CHECKER::is_password_valid("Abcdefghijklmnopqrq"), 'Password "Abcdefghijklmnopqrq" is valid (16-19 chars)');
ok(!PW_REGEX_CHECKER::is_password_valid("abcdefghijklmnopaqa"), 'Password "abcdefghijklmnopaqa" is invalid (16-19 chars, missing uppercase)');

# Test for valid 20+ character passwords
ok(PW_REGEX_CHECKER::is_password_valid("anycharactersyouwantlongpassword"), 'Password "anycharactersyouwantlongpassword" is valid (20+ chars)');
ok(PW_REGEX_CHECKER::is_password_valid("A1!b2\@c3#d4\$e5%f6^g7&h8*i9(j0)k-"), 'Password "A1!b2@c3#d4$e5%f6^g7&h8*i9(j0)k-" is valid (20+ chars)');
ok(PW_REGEX_CHECKER::is_password_valid("AAAAAAAAAAAAAAAAAAAA"), 'Password "AAAAAAAAAAAAAAAAAAAA" is valid (20+ chars)');
ok(PW_REGEX_CHECKER::is_password_valid("12345678901234567890"), 'Password "12345678901234567890" is valid (20+ chars)');
ok(PW_REGEX_CHECKER::is_password_valid("~!@#\$%^&*()_+{}|:<>?"), 'Password "~!@#$%^&*()_+{}|:<>?" is valid (20+ chars)');
