
queens(Matrix) :-
    matrix_values(Matrix, Values), fd_domain_bool(Values),
    
    rows(Matrix),
    matrix_transpose(Matrix, Transposed), rows(Transposed),
    matrix_diagonals(Matrix, Diagonals), diags(Diagonals),
    
    fd_labeling(Values, [variable_method(random), value_method(max)]).

diags([]).
diags([Diag|Rest]) :-
    fd_atmost(1, Diag, 1),
    diags(Rest).

rows([]).
rows([Line|Rest]) :-
    fd_exactly(1, Line, 1),
    rows(Rest).

print_([Line|Rest]) :-
    write(Line), nl, print_(Rest).

print_([]) :-
    nl.

go(N) :-
    matrix_create(N, N, Matrix), queens(Matrix),
    write('-----------'), nl,
    print_(Matrix), nl, nl.