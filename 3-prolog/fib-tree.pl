fib(0, 0).
fib(1, 1).
fib(X, Y) :-
    X > 1,
    X2 is X - 2, fib(X2, Y2),
    X1 is X - 1, fib(X1, Y1),
    Y is Y2 + Y1.
%% crashed at `fib(30, What).` already.
