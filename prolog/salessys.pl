% Sales system knowledgebase
    % Orders: order(customer_name, item_name, quantity).
    order(david, tv, 1). order(john, dvd_player, 1).
    order(david, camera, 2). order(tom, cell_phone, 1).
    order(david, cell_phone, 1).
    order(tom, tv, 2). order(sam, camera, 3).
    order(sam, tv, 1). order(dave, camera, 2).
    order(dave, dvd_player, 1).

    % Customers: customer(name, credit_rating).
    customer(david, 600).
    customer(john, 300).
    customer(tom, 700).
    customer(sam, 500).
    customer(dave, 650).

    % inventory: item(name, quantity_in_stock)
    item(tv, 2). item(dvd_player, 1).
    item(camera, 5). item(cell_phone, 2).


    % added code
    % Good credit, credit >= 500
    goodcredit(X) :- customer(X,Y), Y >= 500.

    % Valid order: has valid costumer with good credit rating
    % with item existing in stock, quantity less than that in stock.
    % Assumes that every customer-item combination is listed as only one order
    validorder(X, Y) :- order(X, Y, Z), goodcredit(X), item(Y, S), Z < S.


    % Queries:
    % All customers who have good credits.
    % goodcredit(X).

    % All orders that are valid.
    % validorder(X,Y).

    % All items that Dave is going to buy.
    % order(dave, X, Y), format('~w',X).

    % All customers who want to buy DVD player
    % order(X, dvd_player, Z), format('~w', X).
