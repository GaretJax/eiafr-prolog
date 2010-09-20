% --- parent (X,Y) : X is parent of Y
parent(sam, jack).
parent(jack, jim).
parent(jack, jill).
parent(jim, ben).
parent(sandy, jack).

% --- man(X) : X is a man
man(sam).
man(jack).
man(jim).
man(ben).

% --- woman(X) : X is a woman
woman(sandy).
woman(jill).

% --- son(X, Y) : X is a son of Y
son(X, Y) :-
    parent(Y, X),
    man(X).

% --- ancestor(Anc, Des) : X is an ancestor of Y
ancestor(Anc, Des) :-
    parent(Anc, Des).
ancestor(Anc, Des) :-
    parent(Anc, X),
    ancestor(X, Des).

