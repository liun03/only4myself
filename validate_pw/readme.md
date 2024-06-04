# Password checker

## Description
Write a **Perl** function that takes in a password and checks whether it's valid. The password should follow the following rule:  
  
Passwords must be at least 8 characters long.  
Between 8-11: requires mixed case letters, numbers and symbols  
Between 12-15: requires mixed case letters and numbers  
Between 16-19: requires mixed case letters  
20+: any characters desired

## Content
1. `main.pl` : The interactive interface to execute the password checker function.
	Look like:
	```
	/validate_pw> perl main.pl
	Input your password
	@1345Qaz
	Valid password!
	```
2. `password_checker.pl`: `check_password` is the function to check password.
3. `test_password_checker.t`: Unit test for `check_password`. Use `Test::Simple`. Before execute the unit test, make sure `Test::Simple` is existed in the lib.

Result:
```
/validate_pw> perl test_password_checker.t                                                                                                                                         
1..28
Password must be at least 8 characters long
ok 1 - Password "short" is too short
Password must be at least 8 characters long
ok 2 - Password "1lSac!^" is too short
Password must be at least 8 characters long
ok 3 - Password "seven7!" is too short
ok 4 - Password "Ab1!abcd" is valid (8-11 chars)
requires mixed case letters, numbers and symbols
ok 5 - Password "Abc!abcd" is invalid (8-11 chars, missing digit)
Password must be at least 8 characters long
ok 6 - Password "Ab1abcd" is invalid (8-11 chars, missing symbol)
ok 7 - Password "A1!aB2@c" is valid (8-11 chars)
requires mixed case letters, numbers and symbols
ok 8 - Password "12345678" is invalid (8-11 chars, missing letters and symbol)
ok 9 - Password "Ab1abcdefabcdef" is valid (12-15 chars)
requires mixed case letters and numbers
ok 10 - Password "Abcdefabcdef" is invalid (12-15 chars, missing digit)
requires mixed case letters and numbers
ok 11 - Password "ababcdefabcde" is invalid (12-15 chars, only lowercase)
requires mixed case letters and numbers
ok 12 - Password "ABCDEFGHIJKL" is invalid (12-15 chars, only lowercase)
ok 13 - Password "A1bcdefghijklm" is valid (12-15 chars)
requires mixed case letters and numbers
ok 14 - Password "abcdefghijklm1" is invalid (12-15 chars, missing uppercase)
ok 15 - Password "Abcdefghijklmnop" is valid (16-19 chars)
requires mixed case letters and numbers
ok 16 - Password "abcdefghijklmno" is invalid (16-19 chars, missing uppercase)
requires mixed case letters
ok 17 - Password "1234567890123456" is invalid (16-19 chars, missing mixed case)
requires mixed case letters
ok 18 - Password "~!@\#$%^&*()<>:][]" is invalid (16-19 chars, missing mixed case)
requires mixed case letters
ok 19 - Password "ABCDEFGHIJKLMNOP" is invalid (16-19 chars, missing lowercase)
requires mixed case letters
ok 20 - Password "ABCDEFGHIJKLMNO!" is invalid (16-19 chars, missing lowercase)
requires mixed case letters
ok 21 - Password "ABCDEFGHIJKLMNO1" is invalid (16-19 chars, missing lowercase)
ok 22 - Password "Abcdefghijklmnopqrq" is valid (16-19 chars)
requires mixed case letters
ok 23 - Password "abcdefghijklmnopaqa" is invalid (16-19 chars, missing uppercase)
ok 24 - Password "anycharactersyouwantlongpassword" is valid (20+ chars)
ok 25 - Password "A1!b2@c3\#d4$e5%f6^g7&h8*i9(j0)k-" is valid (20+ chars)
ok 26 - Password "AAAAAAAAAAAAAAAAAAAA" is valid (20+ chars)
ok 27 - Password "12345678901234567890" is valid (20+ chars)
ok 28 - Password "~!@\#$%^&*()_+{}|:<>?" is valid (20+ chars)
```
