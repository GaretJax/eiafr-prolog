not(A) :- A, !, fail.
not(_).

egal(A, A).

owns([_Y|Ys], X) :- owns(Ys, X).
owns([X|_Xs], X).

owns3([X|_], X).
owns3([_|Ys], X) :- owns3(Ys, Z), egal(X, Z).

owns4([X], X).
owns4([X, _], X).
owns4([_|Ys], X) :- owns4(Ys, X).