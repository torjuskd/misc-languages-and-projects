%   topo_sort(+Nodes, ?Sorted_Nodes)
%   answers a topological sort of a list of Nodes,
%   assumed to belong to a graph given by edge(From, To).

topo_sort([], []) :- !.
topo_sort(L, [Sink|Topo]) :-
     find_sink(L, [], BeforeSink, Sink, AfterSink),
     append(BeforeSink, AfterSink, LminSink),
     topo_sort(LminSink, Topo).

find_sink([Sink], BeforeSink, BeforeSink, Sink, []) :-
     edge(Sink, X),
     member(X, [Sink|BeforeSink]),
     !,
     fail.
find_sink([H|T], Seen, BeforeSink, Sink, AfterSink) :-
     edge(H, Hsucc),
     ( member(Hsucc, Seen) ; member(Hsucc, [H|T]) )
     !,
     find_sink(T, [H|Seen], BeforeSink, Sink, AfterSink).
find_sink([Sink|AfterSink], BeforeSink, BeforeSink, Sink, AfterSink).

