
itrlist_new(e([], [])).

itrlist_apply(e([], Xs),     isFirst,    e([], Xs)).
itrlist_apply(e(Xs, []),     isLast,     e(Xs, [])).

itrlist_apply(e(Xs, Ys),     insertAfter(Y),    e(Xs, [Y|Ys])).
itrlist_apply(e(Xs, Ys),     insertBefore(X),   e(XsX, Ys)) :-
    append(Xs, [X], XsX).

itrlist_apply(e(Xs, [Y|Ys]),    consultAfter(Y),    e(Xs, [Y|Ys])).
itrlist_apply(e(Xs, [Y|Ys]),    removeAfter(Y),     e(Xs, Ys)).

itrlist_apply(e(Xs, [Y|Ys]),    goToNext,   e([Y|Xs], Ys)).
itrlist_apply(e([X|Xs], Ys),    goToPrev,   e(Xs, [X|Ys])).


% Test
itrlist_new(A),
itrlist_apply(A, insertAfter(a), B),
itrlist_apply(B, insertAfter(b), C),
itrlist_apply(C, insertAfter(c), D),
itrlist_apply(D, insertAfter(d), E),
itrlist_apply(E, goToNext, F),
itrlist_apply(F, goToNext, G),
itrlist_apply(G, goToNext, H),
itrlist_apply(H, goToPrev, I).