projSolve(Prefs, Prjs, Attrib, Cost, OptMethod) :-
    mismatch(Prefs, Attrib, Cost),
    checkOcc(Prjs, Attrib),
    projLabeling(Attrib, Cost, OptMethod).

projLabeling(Attrib, Cost, min) :-
    fd_minimize(fd_labeling(Attrib), Cost).

projLabeling(Attrib, Cost, below(N)) :-
    Cost #< N,
    fd_labeling(Attrib).

checkOcc([], _Attrib).

checkOcc([e(M,Min,Max)|Prjs], Attrib) :-
    fd_atmost(Max, Attrib, M),
    fd_atleast(Min, Attrib, M),
    checkOcc(Prjs, Attrib).

mismatch([],[],_Cost).

mismatch([P|Prefs], [A|Attrib], Cost) :-
    fd_element(Rank, P, A),
    mismatchOne(Rank, Cost1),
    mismatch(Prefs, Attrib, Cost2),
    Cost #= Cost2 + Cost1.

mismatchOne(Rank, Cost) :-
    Cost #= (Rank-1)*(Rank-1).


% ======================================================================

rndPrefs(0, _, []).
rndPrefs(N, M, [P|Prefs]) :- N>0,
        rndPerm(M, [], P),
        N1 is N-1,
        rndPrefs(N1, M, Prefs).


rndPerm(M, Ls) :- rndPerm(M, [], Ls).
rndPerm(0, Ls, Ls).
rndPerm(M, Acc, Ls) :- M>0,
        length(Acc, I),
        I1 is I+1,
        random(0, I1, X),
        insertAt(Acc, X, M, Acc1),
        M1 is M-1,
        rndPerm(M1, Acc1, Ls).


insertAt(As, 0, X, [X|As]).
insertAt([A|As], I, X, [A|Rs]) :- I>0, I1 is I-1,
        insertAt(As, I1, X, Rs).


projTest(N, Prjs, Prefs, A, C, Seed, Opt) :-
        set_seed(Seed),
        length(Prjs, M),
        rndPrefs(N, M, Prefs),
        projSolve(Prefs, Prjs, A, C, Opt).


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


go:-
        %projTest(6, Prefs, A, C, 10, min),
        projTest(18, Prefs, A, C, 10, min),
        write('Prefs: '),  write(Prefs), nl,
        write('Attrib: '), write(A),     nl,
        write('Cost: '),   write(C).

go(Nbr):-
        projTest(Nbr, Prefs, A, C, 10, min),
        write('Prefs: '),  write(Prefs), nl,
        write('Attrib: '), write(A),     nl,
        write('Cost: '),   write(C).

