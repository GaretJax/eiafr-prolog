factorial(0, F, F).

factorial(N, F, A) :-
	N > 0,
	A1 is N * A,
	N1 is N - 1,
	factorial(N1, F, A1).

factorial(N, F) :-
	factorial(N, F, 1).