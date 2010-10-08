owns([X|_Xs], X).
owns([_Y|Ys], X) :-
    owns(Ys, X).

