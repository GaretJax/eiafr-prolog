
countAB(FILE) :-
    catch(
        open(FILE, read, In),
    error(existence_error(E, F), G), (
        write('I/O error on file '), write(F), fail)
    ),
    get_char(In, C),
    process_char(C, In, 0, 0, A, B),
    write('The file '), write(FILE), write(' contains '), write(A),
    write(' a and '), write(B), write(' b'), nl.


process_char(end_of_file, In, A, B, A, B) :- 
    close(In), !.

process_char(a, In, Ac, Bc, A, B) :-
    A1c is Ac + 1,
    get_char(In, C),
    process_char(C, In, A1c, Bc, A, B), !.

process_char(b, In, Ac, Bc, A, B) :-
    B1c is Bc + 1,
    get_char(In, C),
    process_char(C, In, Ac, B1c, A, B), !.

process_char(_, In, Ac, Bc, A, B) :-
    get_char(In, C),
    process_char(C, In, Ac, Bc, A, B).
    