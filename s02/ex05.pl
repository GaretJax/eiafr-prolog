listPrefix([X|Xs],[X|Ys]) :- listPrefix(Xs,Ys).
listPrefix(_, []).

listSuffix(Ls, Ls).
listSuffix([_|Ls], S) :- listSuffix(Ls, S).

listSublist1(Ls, Ss) :- 
    listSuffix(Ps, Ss),
    listPrefix(Ls, Ps).

listSublist2(Ls, Ss) :- 
    listPrefix(Ls, Ps), 
    listSuffix(Ps, Ss).

listSublist3(Ls, Ss) :- 
    listSuffix(Ls, Sufs),
    listPrefix(Sufs, Ss).
