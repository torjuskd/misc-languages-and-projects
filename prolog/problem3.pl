dislikes(tom, X) :- third(X), likes(X, dave).
    dislikes(sam, dave).
    dislikes(pete, dave).
    likes(dave, hardworker(X)).
    likes(dave, first(X)).
    likes(sam, tom).
    likes(pete, tom).
    likes(jane, dave).
    first(pete).
    first(nigel).
    third(sam).
    third(jane).
    hardworker(pete).
    hardworker(nigel).
    hardworker(jane).

    % Who does tom dislike?
    #dislikes(tom, X).
