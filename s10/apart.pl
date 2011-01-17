% =============================================================================
% Ex. 1a

x ∈ {1, 2, 3}
y ∈ {1, 2}
z ∈ {3, 4, 5}


% =============================================================================
% Ex. 1a

% See attached image


% =============================================================================
% Ex. 2a

% With two predicates

apart(X, Y, N) :-
    X #> Y, X-Y #> N.

apart(X, Y, N) :-
    Y #> X, Y-X #> N.

% With a single predicate

apart(X, Y, N) :-
    ((X #> >) #/\ (X-Y #> N)) #\/ ((X #<Y) #/\ (Y-X #> N)).


% =============================================================================
% Ex. 2b

ex2(A, B, C) :-
    fd_domain([A, B, C], 0, 10),
    apart(A, B, 3),
    apart(A, C, 3),
    apart(B, C, 3),
    9 * (A - 5) + 8 * (B - 5) + 4 * (C - 5) #= 0,
    fd_labeling([A, B, C]).


% =============================================================================
% Ex. 3

% See attachments to email sent December 13, 2010 for the source code.
% Full benchmark results follow:

% $ ./benchmark.sh
% triplet       found  104 solutions in   7 ms for N=100  and repeating for 2 times
% triplet       found  772 solutions in 207 ms for N=500  and repeating for 2 times
% triplet       found 1762 solutions in 873 ms for N=1000 and repeating for 2 times
% triplet1      found  104 solutions in   7 ms for N=100  and repeating for 2 times
% triplet1      found  772 solutions in 207 ms for N=500  and repeating for 2 times
% triplet1      found 1762 solutions in 871 ms for N=1000 and repeating for 2 times
% triplet2      found   52 solutions in   5 ms for N=100  and repeating for 2 times
% triplet2      found  386 solutions in 137 ms for N=500  and repeating for 2 times
% triplet2      found  881 solutions in 580 ms for N=1000 and repeating for 2 times
% triplet2a     found   52 solutions in   9 ms for N=100  and repeating for 2 times
% triplet2a     found  386 solutions in 211 ms for N=500  and repeating for 2 times
% triplet2a     found  881 solutions in 898 ms for N=1000 and repeating for 2 times
% triplet3      found  104 solutions in   7 ms for N=100  and repeating for 2 times
% triplet3      found  772 solutions in 195 ms for N=500  and repeating for 2 times
% triplet3      found 1762 solutions in 820 ms for N=1000 and repeating for 2 times
% triplet12     found   52 solutions in   5 ms for N=100  and repeating for 2 times
% triplet12     found  386 solutions in 138 ms for N=500  and repeating for 2 times
% triplet12     found  881 solutions in 589 ms for N=1000 and repeating for 2 times
% triplet12a    found   52 solutions in   8 ms for N=100  and repeating for 2 times
% triplet12a    found  386 solutions in 216 ms for N=500  and repeating for 2 times
% triplet12a    found  881 solutions in 912 ms for N=1000 and repeating for 2 times
% triplet13     found  104 solutions in   7 ms for N=100  and repeating for 2 times
% triplet13     found  772 solutions in 196 ms for N=500  and repeating for 2 times
% triplet13     found 1762 solutions in 831 ms for N=1000 and repeating for 2 times
% triplet22a    found   52 solutions in   7 ms for N=100  and repeating for 2 times
% triplet22a    found  386 solutions in 215 ms for N=500  and repeating for 2 times
% triplet22a    found  881 solutions in 950 ms for N=1000 and repeating for 2 times
% triplet23     found   52 solutions in   5 ms for N=100  and repeating for 2 times
% triplet23     found  386 solutions in 137 ms for N=500  and repeating for 2 times
% triplet23     found  881 solutions in 581 ms for N=1000 and repeating for 2 times
% triplet2a3    found   52 solutions in   3 ms for N=100  and repeating for 2 times
% triplet2a3    found  386 solutions in  79 ms for N=500  and repeating for 2 times
% triplet2a3    found  881 solutions in 330 ms for N=1000 and repeating for 2 times
% triplet122a   found   52 solutions in   8 ms for N=100  and repeating for 2 times
% triplet122a   found  386 solutions in 214 ms for N=500  and repeating for 2 times
% triplet122a   found  881 solutions in 910 ms for N=1000 and repeating for 2 times
% triplet123    found   52 solutions in   5 ms for N=100  and repeating for 2 times
% triplet123    found  386 solutions in 136 ms for N=500  and repeating for 2 times
% triplet123    found  881 solutions in 580 ms for N=1000 and repeating for 2 times
% triplet12a3   found   52 solutions in   3 ms for N=100  and repeating for 2 times
% triplet12a3   found  386 solutions in  80 ms for N=500  and repeating for 2 times
% triplet12a3   found  881 solutions in 332 ms for N=1000 and repeating for 2 times
% triplet22a3   found   52 solutions in   2 ms for N=100  and repeating for 2 times
% triplet22a3   found  386 solutions in  62 ms for N=500  and repeating for 2 times
% triplet22a3   found  881 solutions in 258 ms for N=1000 and repeating for 2 times
% triplet122a3  found   52 solutions in   3 ms for N=100  and repeating for 2 times
% triplet122a3  found  386 solutions in  64 ms for N=500  and repeating for 2 times
% triplet122a3  found  881 solutions in 276 ms for N=1000 and repeating for 2 times


% =============================================================================
% Ex. 4

solve(A, B, C, D, E, F, G, H, I) :-
    fd_domain([A, B, C, D, E, F, G, H, I], 1, 9),
    fd_all_different([A, B, C, D, E, F, G, H, I]),
    
    BC #= 10*B + C,
    EF #= 10*E + F,
    HI #= 10*H + I,
    
    A * EF * HI + D * BC * HI + G * EF * BC #= BC * EF * HI,
    
    fd_labeling([A, B, C, D, E, F, G, H, I]).

% | ?- benchmark(200, solve(A, B, C, D, E, F, G, H, I)).
% there are 6 solutions
% Real time : 16695

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

% | ?- benchmark(200, solve1(A, B, C, D, E, F, G, H, I)).
% there are 1 solutions
% Real time : 2287


% =============================================================================
% Ex. 5

% Correct solution for 6x + 4y <= 24:
% http://www.wolframalpha.com/input/?i=Maximize%5B%7B5+x+%2B+4+y%2C+6+x+%2B+4+y+%3C%3D+24%2C+x+%2B+2+y+%3C%3D+6%2C+-x+%2B+y+%3C%3D+1%2C++++y+%3C%3D+2+x+%3E%3D+0%2C+y+%3E%3D+0+%7D%2C+%7Bx%2C+y%7D%5D
%
% Correct solution for 6x + 4y <= 25:
% http://www.wolframalpha.com/input/?i=Maximize%5B%7B5+x+%2B+4+y%2C+6+x+%2B+4+y+%3C%3D+25%2C+x+%2B+2+y+%3C%3D+6%2C+-x+%2B+y+%3C%3D+1%2C++++y+%3C%3D+2+x+%3E%3D+0%2C+y+%3E%3D+0+%7D%2C+%7Bx%2C+y%7D%5D

maximize1(Z, X, Y, N) :-
    % Special version to show the wrong behavior (follow the links above to
    % obtain the correct version).
    %
    % By using this domain-conversion method, we find only maxima for z in N
    % (with N the natural numbers set), as combinations of x and y which
    % produce non-integers values for Z will never be taken into account
    % (as they are not present in the declared domain).
    
    E is truncate(10 ** (N-1)),
    M is 7 * E,
    
    fd_domain([X1, Y1, Z], 0, M),
    
     5 * X1 + 4 * Y1 #=   Z * E,
     
    % Set the constraint to 25 to show the wrong behavior
     6 * X1 + 4 * Y1 #=< 25 * E,
     
         X1 + 2 * Y1 #=<  6 * E,
    -1 * X1 +     Y1 #=<  1 * E,
                  Y1 #=<  2 * E,
    
    fd_maximize(fd_labeling([X1, Y1, Z]), Z),
    
    X is X1/E, Y is Y1/E.

maximize(Z, X, Y, N) :-
    % To obviate to this problem, the domain of Z has to be extended to its
    % maximal value (= domain of X,Y * E) and Z shall not be multiplied by E
    % inside the constraint definition block.
    
    E is truncate(10 ** (N-1)),
    M is 7 * E,
    M2 is M * E,
    
    fd_domain([X1, Y1], 0, M),
    fd_domain([Z1], 0, M2),
    
    % Don't multiply Z times E here, but allow for all intermediary values
    % in the domain directly.
     5 * X1 + 4 * Y1 #=  Z1,
     
    % Set the constraint to 25 to show the right behavior
     6 * X1 + 4 * Y1 #=< 25 * E,
     
         X1 + 2 * Y1 #=<  6 * E,
    -1 * X1 +     Y1 #=<  1 * E,
                  Y1 #=<  2 * E,
    
    fd_maximize(fd_labeling([X1, Y1, Z1]), Z1),
    
    X is X1/E, Y is Y1/E, Z is Z1/E.


% =============================================================================
% Ex. 6

projSolve(Prefs, Prjs, Attrib, Cost, OptMethod) :-
    mismatch(Prefs, Attrib, Cost),
    checkOcc(Prjs, Attrib),
    projLabeling(Attrib, Cost, OptMethod).

projLabeling(Attrib, Cost, min) :-
    fd_minimize(fd_labeling(Attrib), Cost).

projLabeling(Attrib, Cost, below(N)) :-
    Cost #< N,
    fd_labeling(Attrib).

checkOcc([], _).

checkOcc([e(V, Min, Max) | Prjs], Attrib) :-
    fd_atleast(Min, Attrib, V),
    fd_atmost(Max, Attrib, V),
    checkOcc(Prjs, Attrib).

mismatch([], [], 0).

mismatch([P | Prefs], [A | Attrib], Cost) :-
    fd_element(Rank, P, A),
    mismatchOne(Rank, C1),
    mismatch(Prefs, Attrib, C2),
    Cost #= C1 + C2.

mismatchOne(Rank, Cost) :-
    Cost #= (Rank - 1) * (Rank - 1).

% | ?- go.
% Prefs: [[11,7,1,8,3,6,10,9,5,4,2,12], [7,4,11,1,9,10,8,5,6,3,2,12],
%         [6,7,8,1,2,11,3,5,4,12,9,10], [12,6,11,2,8,4,5,9,3,7,1,10],
%         [11,2,8,10,12,6,5,1,7,4,9,3], [2,9,10,11,12,4,6,8,3,7,1,5],
%         [10,2,11,3,4,8,7,6,5,9,1,12], [5,3,11,9,6,1,4,10,12,8,7,2],
%         [2,9,8,1,11,12,4,7,10,3,5,6], [12,2,3,1,6,9,5,8,4,10,11,7],
%         [7,3,9,6,5,8,1,10,12,4,2,11], [12,11,7,5,10,1,3,2,9,8,6,4],
%         [11,10,2,1,4,8,9,5,6,12,7,3], [3,5,2,9,4,1,10,8,12,7,11,6],
%         [10,11,12,3,7,4,1,6,5,9,2,8], [1,5,7,10,9,4,8,3,2,12,6,11],
%         [3,11,5,7,6,10,1,8,9,12,2,4], [7,1,8,3,9,4,12,10,2,6,5,11]]
% Attrib: [11,4,6,6,11,2,10,5,2,12,7,12,4,3,10,1,3,7]
% Cost: 18


% =============================================================================
% Ex. 7

% queens(+BoardSize, -ResultMatrix)
queens(N, Matrix) :-
    matrix_create(N, N, Matrix),
    matrix_values(Matrix, Values), fd_domain_bool(Values),
    
    % Impose constraints
                                            rows_cols(Matrix),
    matrix_transpose(Matrix, Transposed),   rows_cols(Transposed),
    matrix_diagonals(Matrix, Diagonals),    diags(Diagonals),
    
    fd_labeling(Values, [variable_method(random), value_method(max)]).

diags([]).
diags([Diag|Rest]) :-
    fd_atmost(1, Diag, 1),
    diags(Rest).

rows_cols([]).
rows_cols([Line|Rest]) :-
    fd_exactly(1, Line, 1),
    rows(Rest).

print_([Line|Rest]) :-
    write(Line), nl, print_(Rest).

print_([]) :-
    nl.

go(N) :-
    queens(N, Matrix),
    write('-----------'), nl,
    print_(Matrix), nl, nl.
