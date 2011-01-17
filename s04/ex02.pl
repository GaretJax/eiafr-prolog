
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
    

