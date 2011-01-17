%
% pUnit
% =====
%
% A simple unittest framework to create prolog unit tests.
% To create a new test simply define a predicate which starts with test_ and
% accepts no arguments, like in the following example::
%
%      test_square :-
%          square(10, 100).
%
% If the predicate succeeds, the test is marked as passed, otherwise it is
% marked as failed.
%
% To test that a given expressions does not succed, the cut and fail
% predicates work well::
%
%      test_fails :-
%          should_fail(), !, fail.
%
%      test_fails.
%
% Suppose your tests are in a file called mytests.pl, then they can be run by
% executing the following shell command (in this case both the mytest.pl and
% punit.pl files have to be in the current working directory)::
%
%      echo "[punit], [mytests], test." | gprolog
%

% Returns a list with all test cases currently defined.
% A test case is a clause whose name starts with test_ and accepts no
% arguments.
%
% search_test_cases(-Ts)
%
search_test_cases(Ts) :-
    search_test_cases(Ts, 'test_', '/0').

% Same as search_test_cases but allows to redefine the prefix and suffix of the
% searched clauses.
%
% search_test_cases(-Ts, +Prefx, +Suffix)
%
search_test_cases(Ts, Prefix, Suffix) :-
    findall(T, search_test_case(T, Prefix, Suffix), Ts).

% Searches a single test case with the given suffix and prefix.
%
% search_test_case(-TestCase, +Prefix, +Suffix)
%
search_test_case(TestCase, Prefix, Suffix) :-
    current_predicate(Pred),
    write_to_chars(Name, Pred),
    write_to_chars(Pr, Prefix),
    write_to_chars(Sf, Suffix),
    prefix(Pr, Name),
    suffix(Sf, Name),
    read_token_from_chars(Name, TestCase).

% Runs all test cases contained in tge given lists and returns a list with the
% results.
%
% runtests(+TestCases, -Results)
%
runtests([T|TestCases], Results) :-
    runtest(T, R),
    runtests(TestCases, RM),
    append(RM, [R], Results).

runtests([], []).

% Runs a single test, returning a result atom containing the execution result.
%
% runtest(+TestCase, -result(state, TestCase))
%
runtest(TestCase, result(passed, TestCase)) :-
    call(TestCase).

runtest(TestCase, result(failed, TestCase)).

% Prints the detailed results of the execution of the test cases.
%
% report(+Results)
%
report([result(passed, TestCase)|Rs]) :-
    write('[PASS] '), write(TestCase), nl, report(Rs).

report([result(failed, TestCase)|Rs]) :-
    write('[FAIL] '), write(TestCase), nl, report(Rs).

report([]).

% Counts the number of passed and failed tests in the given list.
%
% counts(+Results, -Passed, -Failed)
%
counts([result(passed, _)|Rs], P, F) :-
    counts(Rs, P1, F), P is P1 + 1.

counts([result(failed, _)|Rs], P, F) :-
    counts(Rs, P, F1), F is F1 + 1.

counts([], 0, 0).

% Searches all tests currently defined, runs them and prints out the results.
%
test :-
    search_test_cases(Ts),
    runtests(Ts, Results),
    nl,
    write('------------------------------------------'), nl,
    report(Results),
    write('------------------------------------------'), nl,
    counts(Results, Passed, Failed), 
    nl,
    write(Passed), write(' test(s) PASSED and '),
    write(Failed), write(' test(s) FAILED.'),
    nl,
    !. % Needed to exit cleanly when piping the commands to the interpreter

