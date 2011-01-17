%--- send a request, receive the answer
call_sqrt(N, Result, ToJava, FromJava) :-
    write(ToJava, 'square'), nl(ToJava), flush_output(ToJava),
    write(ToJava, N),        nl(ToJava), flush_output(ToJava),
    read_integer(FromJava, Result).

%--- start process, open connection
start_java(ToJava, FromJava) :- 
    Cmd = 'java CalledFromProlog',
    exec(Cmd, ToJava, FromJava, _FromJavaErr).

%--- send exit request
close_java(ToJava) :-
    write(ToJava, 'bye'), nl(ToJava), flush_output(ToJava).

%--- mini-demo main
go :- 
    start_java(Send, Receive),
    call_sqrt(3, X, Send, Receive),
    write('output is '), write(X), nl,
    call_sqrt(X, Y, Send, Receive),
    write('output is '), write(Y), nl,
    close_java(Send).
