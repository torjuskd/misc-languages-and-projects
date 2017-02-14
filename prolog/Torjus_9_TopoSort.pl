%! Program for topologically sorting

    %! INPUT:
    %!  ?- topoSort ([[1, 2, 3, 4], [2, 4, 5], [3, 6], [4, 3, 6, 7], [5, 4, 7], [6], [7, 6]], X).

    %! OUTPUT:
    /**  %! X = [1, 2, 5, 4, 3, 7, 6] ;
* %! X = [1, 2, 5, 4, 7, 3, 6].
*/

    topoSort([H|T],X) :- .

    points(X,[]).
    points([H|T]) :- .
