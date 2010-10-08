listConcat([], Ys, Ys).
listConcat([_|Xs], Ys, [_|XsYs]) :- listConcat(Xs, Ys, XsYs).
