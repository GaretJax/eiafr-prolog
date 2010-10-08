% =========================================================================
% FILE     : bulle.pl
% SUPPORT  : Bapst Frederic, EIA-FR.
% UPDATE   : 02.10.05
% CONTEXT  : Techniques Avancées de Programmation 3 : Programmation Logique
% =========================================================================
% OVERVIEW : First steps in Prolog
% =========================================================================

%---------------------------------------------
%----------- S01 - Ex. 1) Vérification : Poser les questions suivantes : 
%---------------------------------------------
%  unify_with_occurs_check(    p(X, f(g(X)), a) , p(b, Y, Z)                    ).
%  unify_with_occurs_check(                 p(X), p(f(X))                       ).
%  unify_with_occurs_check( p(X, f(X),g(f(X),X)), p(Z, f(f(a)), g(f(g(a,Z)),v)) ).
%  unify_with_occurs_check(    p(X,f(X),f(f(X))), p(f(f(Y)),Y,f(Y))             ).
%  unify_with_occurs_check(               p(X,Y), p(f(Z),X)                     ).

%---------------------------------------------
%----------- S01 - Ex. 2)
%---------------------------------------------

a :- b, c.
a :- d.
b :- c, d.
c.
d.
e.
g(F, t, F).
f(a, B, c, D, E, E) :- g(B, D, E).

%---------------------------------------------
%----------- S01 - Ex 3)
%---------------------------------------------

%--- road(X,Y): there is a road from X to Y

road(montbovon, bulle).
road(bulle, fribourg).
road(fribourg, montbovon).

%--- path(X,Y): we can reach Y from X

path(X,Y) :-
    road(X, Z),
    path(Z, Y).
path(X,Y) :- 
    road(X, Y).