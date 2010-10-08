
partition(_, [], [], []).

partition(Pivot, [X|List], [X|Smaller], Bigger) :-
    X < Pivot, partition(Pivot, List, Smaller, Bigger).

partition(P, [X|List], Smaller, [X|Bigger]) :-
    X >= Pivot, partition(Pivot, List, Smaller, Bigger).


quicksort([], []).

quicksort([Pivot|List], Sorted) :-
    partition(Pivot, List, Left, Right),
    quicksort(Left, LeftSorted), quicksort(Right, RightSorted),
    append(LeftSorted, [Pivot], First), append(First, RightSorted, Sorted).


% Test
quicksort([3,2,1], Ss).