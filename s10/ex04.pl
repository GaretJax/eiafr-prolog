
solve(A, B, C, D, E, F, G, H, I) :-
    fd_domain([A, B, C, D, E, F, G, H, I], 1, 9),
    fd_all_different([A, B, C, D, E, F, G, H, I]),
    
    BC #= 10*B + C,
    EF #= 10*E + F,
    HI #= 10*H + I,
    
    A * EF * HI + D * BC * HI + G * EF * BC #= BC * EF * HI,
    
    fd_labeling([A, B, C, D, E, F, G, H, I]).
    
solve1(A, B, C, D, E, F, G, H, I) :-
    fd_domain([A, B, C, D, E, F, G, H, I], 1, 9),
    fd_all_different([A, B, C, D, E, F, G, H, I]),
    
    BC #= 10*B + C,
    EF #= 10*E + F,
    HI #= 10*H + I,
    
    A * 3 #> BC,
    
    D * HI #< G * EF,
    
    A * EF * HI + D * BC * HI + G * EF * BC #= BC * EF * HI,
    
    fd_labeling([A, B, C, D, E, F, G, H, I]).