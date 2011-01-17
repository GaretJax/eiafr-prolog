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
    Cost #= (Rank-1) * (Rank-1).

% ======================================================================
% ==== Test program (random preferences)
% ======================================================================

%---- rndPrefs(N, M, Ls) : Ls is a list of N possible
%                          preferences over projects [1..M]
rndPrefs(0, _, []).
rndPrefs(N, M, [P|Prefs]) :- N>0,
        rndPerm(M, [], P),
        N1 is N-1,
        rndPrefs(N1, M, Prefs).

%---- rndPerm(+M, -Ls) : Ls is a random permutation of [1,2,3,4,...,M]
rndPerm(M, Ls) :- rndPerm(M, [], Ls).
rndPerm(0, Ls, Ls).
rndPerm(M, Acc, Ls) :- M>0,
        length(Acc, I),
        I1 is I+1,
        random(0, I1, X),
        insertAt(Acc, X, M, Acc1),
        M1 is M-1,
        rndPerm(M1, Acc1, Ls).

%---- insertAt(+Where, +Pos, +What, ?Result)
insertAt(As, 0, X, [X|As]).
insertAt([A|As], I, X, [A|Rs]) :- I>0, I1 is I-1,
        insertAt(As, I1, X, Rs).

%---- projTest(+NbStudents, +Prjs, -RndPrefs, ?Attrib, ?Cost, +OptMethod)
projTest(N, Prjs, Prefs, A, C, Seed, Opt) :-
        set_seed(Seed),
        length(Prjs, M),
        rndPrefs(N, M, Prefs),
        projSolve(Prefs, Prjs, A, C, Opt).

%---- projTest(+NbStudents, -RndPrefs, ?Attrib, ?Cost, +OptMethod)
projTest(N, Prefs, A, C, Seed, Opt) :-
        Prjs = [
         e(1,1,2), 
         e(2,1,2),
         e(3,1,2),
         e(4,2,2),
         e(5,0,2),
         e(6,0,2),
         e(7,0,2),
         e(8,0,1),
         e(9,0,2),
         e(10,0,2),
         e(11,0,2),
         e(12,0,2)
        ],
        projTest(N, Prjs, Prefs, A, C, Seed, Opt).

% ------------------------------------------------------------
go:- 
        projTest(18, Prefs, A, C, 10, min),
        write('Prefs: '),  write(Prefs), nl,
        write('Attrib: '), write(A),     nl,
        write('Cost: '),   write(C).

% ------------------------------------------------------------
% --- Should be (with quadratic cost : Cost #= (Rank-1)*(Rank-1) ) :
%
% Prefs: [[3,2,5,10,6,4,9,8,7,12,1,11],[11,4,2,10,7,8,6,3,5,12,9,1],[9,7,1,4,8,3,5,11,10,12,6,2],...]
% Attrib: [3,11,9,12,3,5,10,4,1,4,11,2,6,7,2,9,12,5]
% Cost: 3
% (4890 ms) yes
% ------------------------------------------------------------