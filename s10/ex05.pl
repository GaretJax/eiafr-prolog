
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

