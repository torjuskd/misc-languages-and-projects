topoSort([],X,Y) :- append([],X,Y). %empty the list.
topoSort(A,X,Y) :- noIns(I,A,A), append(X,[I],L), takeout(I,A,R), topoSort(R,L,Y). %toposort main part
topoSort(A,X) :- topoSort(A,[],X). %take out the empty list

takeout(X,[[X|_]|R],R). %take out the empty list.
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

dropfirst([_|A],A). %drop the first element which we don't compare with themselves
returnlist(B,R,L) :- maplist(dropfirst,B,R),append(R,L). %return a list of out edges

noIns(X,[[X|_]|_],B) :- returnlist(B,_,L),\+member(X,L). %returns vertices with 0 in degree.
noIns(X,[_|A],B) :- noIns(X,A,B).