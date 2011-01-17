% =========================================================================
% FILE     : clp.pl
% SUPPORT  : Bapst Frederic, EIA-FR.
% UPDATE   : 02.10.01
% CONTEXT  : Techniques Avancées de Programmation 3 : Programmation Logique
% =========================================================================
% OVERVIEW : Constraint Logic Programming, Finite-Domain in GnuProlog
% =========================================================================

% ------------------------------------------------------------
ex1a(X,Y,Z) :- fd_domain(X,1,5),
               fd_domain(Y,1,10),
               fd_domain(Z,0,5),
               X+2*Y#=Z.
% ------------------------------------------------------------
donald(LD):-
        LD=[D,O,N,A,L,G,E,R,B,T],
        fd_all_different(LD),
        fd_domain(LD,0,9),
        fd_domain([D,G],1,9),  %--- Optional... See why ?
           100000*D+10000*O+1000*N+100*A+10*L+D +
           100000*G+10000*E+1000*R+100*A+10*L+D
        #= 100000*R+10000*O+1000*B+100*E+10*R+T,
        fd_labelingff(LD).
% ------------------------------------------------------------
% --- maximize     2a + 3b
% ---   subject to a+b<50, 4a-b<88, a,b in [0..1000]

test2(A,B) :- 
        % fd_domain([A,B],0,...),
            Z #= 3*A+2*B,
          A+B #< 50,
        4*A-B #< 88,
        fd_maximize(fd_labeling([A,B]), Z).
% ------------------------------------------------------------
% --- find a,b,c such that a is multiple of 4 or 9, abc=140, a+b+c=16

test1(A,B,C) :- 
        fd_domain([A,B,C],0,16), 
        checkMultiple(A),
        A*B*C#=140,
        A+B+C#=16,
        fd_labeling([A,B,C]).

checkMultiple(X) :- X rem 4 #= 0.
checkMultiple(X) :- X rem 9 #= 0.

% ------------------------------------------------------------
% ---- benchmark(HowManyTimes, Goal) : measures duration to solve Goal

benchmark(N, P) :-
        statistics(real_time, _),
        benchmark(N, P, S),
        statistics(real_time, [_, Duration]),
        length(S,NbSol),
        write('there are '),write(NbSol), write(' solutions'), nl,
        write('Real time : '), write(Duration), nl,
        fail.
benchmark(0, _, _).
benchmark(N, P, S) :- N>0, N1 is N-1,
        findall(a, P, S), 
        benchmark(N1, P, _).

% ------------------------------------------------------------