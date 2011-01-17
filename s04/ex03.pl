
concat1(As, Bs, Cs, Ls) :-
    append(As, Bs, Xs),
    append(Xs, Cs, Ls).

concat2(As, Bs, Cs, Ls) :-
    append(Xs, Cs, Ls),
    append(As, Bs, Xs).

concat3(As, Bs, Cs, Ls) :-
    var(Ls),
    concat1(As, Bs, Cs, Ls).

concat3(As, Bs, Cs, Ls) :-
    nonvar(Ls),
    concat2(As, Bs, Cs, Ls).


% The question concat(+, +, +, -) is answered correctly only by concat1, as
% concat2 will find an infinite number of answers for the question append(-, +, -).

% The other way around, the question(-, +, +, +) is answered correctly only by
% concat2, as concat1 causes exactly the same problem as before.

% concat3 answers correctly to both, but only because it does a check on Ls to
% choose which predicate to execute.

% To answer to the question c, the predciate concat1 is best suited as it
% immediately narrows the solutions vector (there is only one possible answer
% to append(+, +, -)), while the predicate concat2 finds first all solutions
% to append(-, -, +) and only then checks if they are correct.