female(mia).
    female(sally).
    male(john).
    male(jack).
    parent(mia, sally).
    parent(john, sally).
    parent(jack, john).
    father(X, Y) :- male(X), parent(X, Y).
    mother(X, Y) :- female(X), parent(X, Y).
    grandfather(X, Y) :- father(X, Z), parent(Z, Y).
    grandmother(X, Y) :- mother(X, Z), parent(Z, Y).


    # grandfather(X, Y).


    # Produces a search tree
    # Run code as follows:
    # ?- reset.
    # ?- trace.
    # ?- fac(s(s(n)),X).
    # X = s(s(n))
    # ?- nodebug.
    # ?- show.
    # http://yuml.me/diagram/scruffy/class/[fac / 2] -> [fac / 2], [fac / 2] -> [mul / 3], [mul / 3] -> [mul / 3], [mul / 3] -> [add / 3], [add / 3] -> [add / 3], Yes


    goal_tracing(call, F) :-
    frame_property(F, sys_call_indicator(N, A)),
    frame_property(F, sys_parent_frame(G)),
    frame_property(G, sys_call_indicator(M, B)),
    !,
    update_link(N / A, M / B).
    goal_tracing(_, _).

    :- dynamic link/2.
    update_link(A, B) :-
    link(A, B),
    !.
    update_link(A, B) :-
    assertz(link(A, B)).

    reset :-
    retract(link(_, _)), fail.
    reset.

    show :-
    write('http://yuml.me/diagram/scruffy/class/'),
    link(A, B),
    write(([B] -> [A])),
    write(', '),
    fail.
    show.
