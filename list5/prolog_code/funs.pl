splitlist([], [], []).
splitlist([X], [X], []).
splitlist([X, Y | Rest], [X | Left], [Y | Right]) :- 
	splitlist(Rest, Left, Right).

merge([], Right, Right).
merge(Left, [], Left).
merge([L | Left], [R | Right], [L | Merged]) :-
	L =< R,
	merge(Left, [R | Right], Merged).
merge([L | Left], [R | Right], [R | Merged]) :-
	L > R,
	merge([L | Left], Right, Merged).

mergesort([], []).
mergesort([X], [X]).
mergesort(List, Sorted) :-
	splitlist(List, Left, Right),
	mergesort(Left, SortedLeft),
	mergesort(Right, SortedRight),
	merge(SortedLeft, SortedRight, Sorted).

de(A, 0, 1, 0, A).
de(A, B, X, Y, Z) :-
	B > 0,
	R is A mod B,
	Q is A // B,
	de(B, R, X1, Y1, Z),
	X is Y1,
	Y is X1 - Q * Y1.

pfactors(1, _, []).
pfactors(N, F, [F | Factors]) :-
	N > 1,
	R is N // F,
	N =:= R * F,
	pfactors(R, F, Factors).
pfactors(N, F, Factors) :-
	N > 1,
	R is N // F,
	N =\= R * F,
	next_factor(F, F1),
	pfactors(N, F1, Factors).

next_factor(2, 3).
next_factor(F, NextF) :-
    F > 2,
    NextF is F + 2.

primefactors(N, Factors) :-
	pfactors(N, 2, Factors).

gcd(A, 0, A).
gcd(A, B, C) :-
	B > 0,
	R is A mod B,
	gcd(B, R, C).

totient(1, 1).
totient(N, T) :-
	N > 1,
	findall(X, (between(1, N, X), gcd(N, X, 1)), Relatives),
	length(Relatives, T).

isprime(2).
isprime(3).
isprime(N) :-
    N > 3,
    N mod 2 =\= 0,
    \+ hasfactor(N, 3).

hasfactor(N, F) :-
    N mod F =:= 0.
hasfactor(N, F) :-
    F * F < N,
    F2 is F + 2,
    hasfactor(N, F2).

primes(N, P) :-
    findall(X, (between(2, N, X), isprime(X)), P).


:- mergesort([9, 8, 7, 6, 5, 4, 3, 2, 1], Y), write(Y), nl.
:- de(27, 15, X, Y, Z), write(X), nl, write(Y), nl, write(Z), nl.
:- primefactors(123, X), write(X), nl.
:- totient(123, X), write(X), nl.
:- primes(123, X), write(X), nl.
