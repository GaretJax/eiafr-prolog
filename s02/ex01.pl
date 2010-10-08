f(As, As, [a,b]) :-
    g(As, _).

f([A|As], [b,A], As) :-
    g(A, As).

f([], Bs, [Bs|Bs]).

g(_, []).

