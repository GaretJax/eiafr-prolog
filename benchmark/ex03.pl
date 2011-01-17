triplet(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    A**2 + B**2 #= C**2,
    fd_labeling([A, B, C]).

triplet1(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labeling([A, B, C]).

triplet2(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A,
    A**2 + B**2 #= C**2,
    fd_labeling([A, B, C]).
    
triplet2a(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    2*B*B #> C*C,
    A**2 + B**2 #= C**2,
    fd_labeling([A, B, C]).

triplet3(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    A**2 + B**2 #= C**2,
    fd_labelingff([A, B, C]).

triplet12(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labeling([A, B, C]).

triplet12a(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    2*B*B #> C*C,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labeling([A, B, C]).

triplet13(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labelingff([A, B, C, AA, BB, CC]).

triplet22a(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A, 2*B*B #> C*C,
    A**2 + B**2 #= C**2,
    fd_labeling([A, B, C]).

triplet23(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A,
    A**2 + B**2 #= C**2,
    fd_labelingff([A, B, C]).

triplet2a3(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    2*B*B #> C*C,
    A**2 + B**2 #= C**2,
    fd_labelingff([A, B, C]).

triplet123(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labelingff([A, B, C, AA, BB, CC]).
    
triplet12a3(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    2*B*B #> C*C,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labelingff([A, B, C, AA, BB, CC]).

triplet122a(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A, 2*B*B #> C*C,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labeling([A, B, C]).

triplet22a3(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A, 2*B*B #> C*C,
    A**2 + B**2 #= C**2,
    fd_labelingff([A, B, C]).

triplet122a3(A, B, C, N) :-
    fd_domain([A, B, C], 1, N),
    B#>A, 2*B*B #> C*C,
    AA #= A*A, BB #= B*B, CC #= C*C,
    AA + BB #= CC,
    fd_labelingff([A, B, C, AA, BB, CC]).

    