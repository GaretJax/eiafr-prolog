
bst_new(nil).

bst_apply(nil,             put(K, V),    n(K,  V,  nil, nil)).
bst_apply(n(K,  _,  L, R), put(K, V),    n(K,  V,  L,   R)  ).
bst_apply(n(K1, V,  L, R), put(K, Val),  n(K1, V,  L1,  R)  ) :-
    K < K1, bst_apply(L,   put(K, Val),  L1                 ).
bst_apply(n(K1, V,  L, R), put(K, Val),  n(K1, V,  L,   R1) ) :-
    K > K1, bst_apply(R,   put(K, Val),  R1                 ).
    
bst_apply(n(K,  V,  L, R), get(K, V),    n(K,  V,  L,   R)  ).
bst_apply(n(K1, V1, L, R), get(K, V),    n(K1, V1, L,   R)  ) :-
    K < K1, bst_apply(L,   get(K, V),    L                  ).
bst_apply(n(K1, V1, L, R), get(K, V),    n(K1, V1, L,   R)  ) :-
    K > K1, bst_apply(R,   get(K, V),    R).

bst_apply(nil,             remove(K), nil                   ).
bst_apply(n(K1, V, L, R),  remove(K), n(K1, V, L1, R)       ) :-
    K < K1, bst_apply(L,   remove(K), L1                    ).
bst_apply(n(K1, V, L, R),  remove(K), n(K1, V, L, R1)       ) :-
    K > K1, bst_apply(R,   remove(K), R1                    ).
bst_apply(n(K, _, L, nil), remove(K), L                     ).
bst_apply(n(K, V, L, n(K_R, V_R, L_R, R_R)), remove(K), n(K_R, V_R, R1, R_R)) :-
    bst_apply(n(K, V, L, L_R), remove(K), R1).

% Test
bst_new(A),
bst_apply(A, put(5, cinque),    B),
bst_apply(B, put(2, due),       C),
bst_apply(C, put(8, otto),      D),
bst_apply(D, put(0, zero),      E),
bst_apply(E, put(10, dieci),    F),
bst_apply(F, put(3, tre),       G),
bst_apply(G, put(7, sette),     H),
bst_apply(H, put(4, quattro),   I),
bst_apply(I, put(9, nove),      J),
bst_apply(J, put(1, uno),       K),
bst_apply(K, remove(7),         L),
bst_apply(L, remove(2),         M),
bst_apply(M, remove(9),         N),
bst_apply(N, remove(3),         O),
bst_apply(O, remove(1),         P),
bst_apply(P, remove(4),         Q),
bst_apply(Q, remove(0),         R),
bst_apply(R, remove(10),        S),
bst_apply(S, remove(5),         T),
bst_apply(T, remove(8),         U). % Should be nil
