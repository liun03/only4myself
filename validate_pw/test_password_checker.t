#!/usr/bin/perl

use Test::Simple tests => 28;
use strict;
use warnings;
require "./password_checker.pl";

# Test for invalid password length
ok(!CHECK_PW::check_password("short"), 'Password "short" is too short');
ok(!CHECK_PW::check_password("1lSac!^"), 'Password "1lSac!^" is too short');
ok(!CHECK_PW::check_password("seven7!"), 'Password "seven7!" is too short');

# Test for valid and invalid 8-11 character passwords
ok(CHECK_PW::check_password("Ab1!abcd"), 'Password "Ab1!abcd" is valid (8-11 chars)');
ok(!CHECK_PW::check_password("Abc!abcd"), 'Password "Abc!abcd" is invalid (8-11 chars, missing digit)');
ok(!CHECK_PW::check_password("Ab1abcd"), 'Password "Ab1abcd" is invalid (8-11 chars, missing symbol)');
ok(CHECK_PW::check_password("A1!aB2\@c"), 'Password "A1!aB2@c" is valid (8-11 chars)');
ok(!CHECK_PW::check_password("12345678"), 'Password "12345678" is invalid (8-11 chars, missing letters and symbol)');

# Test for valid and invalid 12-15 character passwords
ok(CHECK_PW::check_password("Ab1abcdefabcdef"), 'Password "Ab1abcdefabcdef" is valid (12-15 chars)');
ok(!CHECK_PW::check_password("Abcdefabcdef"), 'Password "Abcdefabcdef" is invalid (12-15 chars, missing digit)');
ok(!CHECK_PW::check_password("ababcdefabcde"), 'Password "ababcdefabcde" is invalid (12-15 chars, only lowercase)');
ok(!CHECK_PW::check_password("ABCDEFGHIJKL"), 'Password "ABCDEFGHIJKL" is invalid (12-15 chars, only lowercase)');
ok(CHECK_PW::check_password("A1bcdefghijklm"), 'Password "A1bcdefghijklm" is valid (12-15 chars)');
ok(!CHECK_PW::check_password("abcdefghijklm1"), 'Password "abcdefghijklm1" is invalid (12-15 chars, missing uppercase)');

# Test for valid and invalid 16-19 character passwords
ok(CHECK_PW::check_password("Abcdefghijklmnop"), 'Password "Abcdefghijklmnop" is valid (16-19 chars)');
ok(!CHECK_PW::check_password("abcdefghijklmno"), 'Password "abcdefghijklmno" is invalid (16-19 chars, missing uppercase)');
ok(!CHECK_PW::check_password("1234567890123456"), 'Password "1234567890123456" is invalid (16-19 chars, missing mixed case)');
ok(!CHECK_PW::check_password("~!\@#\$%^&*()<>:][]"), 'Password "~!@#$%^&*()<>:][]" is invalid (16-19 chars, missing mixed case)');
ok(!CHECK_PW::check_password("ABCDEFGHIJKLMNOP"), 'Password "ABCDEFGHIJKLMNOP" is invalid (16-19 chars, missing lowercase)');
ok(!CHECK_PW::check_password("ABCDEFGHIJKLMNO!"), 'Password "ABCDEFGHIJKLMNO!" is invalid (16-19 chars, missing lowercase)');
ok(!CHECK_PW::check_password("ABCDEFGHIJKLMNO1"), 'Password "ABCDEFGHIJKLMNO1" is invalid (16-19 chars, missing lowercase)');
ok(CHECK_PW::check_password("Abcdefghijklmnopqrq"), 'Password "Abcdefghijklmnopqrq" is valid (16-19 chars)');
ok(!CHECK_PW::check_password("abcdefghijklmnopaqa"), 'Password "abcdefghijklmnopaqa" is invalid (16-19 chars, missing uppercase)');

# Test for valid 20+ character passwords
ok(CHECK_PW::check_password("anycharactersyouwantlongpassword"), 'Password "anycharactersyouwantlongpassword" is valid (20+ chars)');
ok(CHECK_PW::check_password("A1!b2\@c3#d4\$e5%f6^g7&h8*i9(j0)k-"), 'Password "A1!b2@c3#d4$e5%f6^g7&h8*i9(j0)k-" is valid (20+ chars)');
ok(CHECK_PW::check_password("AAAAAAAAAAAAAAAAAAAA"), 'Password "AAAAAAAAAAAAAAAAAAAA" is valid (20+ chars)');
ok(CHECK_PW::check_password("12345678901234567890"), 'Password "12345678901234567890" is valid (20+ chars)');
ok(CHECK_PW::check_password("~!@#\$%^&*()_+{}|:<>?"), 'Password "~!@#$%^&*()_+{}|:<>?" is valid (20+ chars)');
