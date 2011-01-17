

test_calculate :-
    square(10, I), I = 100.


test_check_ok :-
    square(10, 100).


test_check_no :-
    square(10, 90), !, fail.

test_check_no.


test_always_fails :-
    fail.


