prime(2).
prime(3).
prime(5).

even(4).
even(2).

a(X) :- prime(X).
a(8).

b(X) :- prime(X), !.
b(8).

c(X) :- !, prime(X).
c(8).

d(X) :- prime(X), even(X), !.
d(8).

e(X) :- even(X), !, prime(X).
e(8).

f(X) :- even(7), !, X=7.
f(8).

g(X, Y) :- prime(X), even(Y), !.
g(8, 8).

h(X, Y) :- prime(X), !, even(Y).
h(8, 8).

i(X, Y) :- even(Y), !, prime(X).
i(8, 8).
