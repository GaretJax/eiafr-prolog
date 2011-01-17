%% EX 01

factorial(0, F, F).

factorial(N, F, A) :-
	N > 0,
	A1 is N * A,
	N1 is N - 1,
	factorial(N1, F, A1).

factorial(N, F) :-
	factorial(N, F, 1).
	
	
%% EX 02

% a) With accumulator

listSumAcc([X], A, S) :-
    S is A + X.

listSumAcc([X|Xs], A, S) :-
    A1 is A + X,
    listSumAcc(Xs, A1, S).

listSumAcc(X, S) :-
    listSumAcc(X, 0, S).


% b) Without accumulator

listSum([X], X).

listSum([X|Xs], S) :-
    listSum(Xs, S1),
    S is X + S1.
    

%% EX 03

% The question concat(+, +, +, -) is answered correctly only by concat1, as
% concat2 will find an infinite number of answers for the question append(-, +, -).

% The other way around, the question(-, +, +, +) is answered correctly only by
% concat2, as concat1 causes exactly the same problem as before.

% concat3 answers correctly to both, but only because it does a check on Ls to
% choose which predicate to execute.

% To answer to the question c, the predciate concat1 is best suited as it
% immediately narrows the solutions vector (there is only one possible answer
% to append(+, +, -)), while the predicate concat2 finds first all solutions
% to append(-, -, +) and only then checks if they are correct.


%% EX 04

countAB(FILE) :-
    catch(
        open(FILE, read, In),
    error(existence_error(E, F), G), (
        write('I/O error on file '), write(F), fail)
    ),
    get_char(In, C),
    process_char(C, In, 0, 0, A, B),
    write('The file '), write(FILE), write(' contains '),
    write(A), write(' a and '),
    write(B), write(' b'), nl.

process_char(end_of_file, In, A, B, A, B) :- 
    close(In), !.

process_char(a, In, Ac, Bc, A, B) :-
    A1c is Ac + 1,
    get_char(In, C),
    process_char(C, In, A1c, Bc, A, B), !.

process_char(b, In, Ac, Bc, A, B) :-
    B1c is Bc + 1,
    get_char(In, C),
    process_char(C, In, Ac, B1c, A, B), !.

process_char(_, In, Ac, Bc, A, B) :-
    get_char(In, C),
    process_char(C, In, Ac, Bc, A, B).
