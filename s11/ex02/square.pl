% No need to define a "main" to read requests and send results :
% the Prolog interpreter itself does the job, but 
% the caller knows how to decode the results...

square(N, M) :- M is N * N.