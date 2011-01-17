
apart(X, Y, N) :-
   ((X #> Y) #/\ (X-Y #> N-1)) #\/ ((X #< Y) #/\ (Y-X #> N-1)).

ex02(X, Y, Z) :-
   fd_domain([A, B, C], 0, 10),
   apart(A, B, 3), apart(A, C, 3), apart(B, C, 3),
   9*(A-5) + 8*(B-5) + 4*(C-5) #= 0,
   fd_labeling([A, B, C]),
   X is A-5, Y is B-5, Z is C-5.