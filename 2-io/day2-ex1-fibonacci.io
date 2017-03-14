/* Write a program to find the nth Fibonacci number.
 * fib(1) is 1, and fib(4) is 3.
 * As a bonus, solve the problem with recursion and with loops. */

fib := method(n, if((n == 1) or (n == 2), 1, fib(n-1)+fib(n-2)))
fib(1) println
fib(4) println
fib(5) println
writeln
fib_loop := method(n, sum := 1;
                      prevprev := 0;
                      prev := 1;
                      for(i, 2, n, sum = prevprev+prev;
                                   prevprev = prev;
                                   prev = sum);
                      sum)
fib_loop(1) println
fib_loop(4) println
fib_loop(5) println
