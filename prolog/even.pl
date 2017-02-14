
    %This works!
    even(X) :- 0 is X mod 2.



  start:- sum,nl.

  sum:- write('X= '),read(X),
    write('Y= '),read(Y),
    S is X+Y,
    write('Sum is '),write(S).



    divisible(X,Y) :- 0 is X mod Y, !.

    divisible(X,Y) :- X > Y+1, divisible(X, Y+1).

    isPrime(2) :- true,!.
    isPrime(X) :- X < 2,!,false.
    isPrime(X) :- not(divisible(X, 2)).
