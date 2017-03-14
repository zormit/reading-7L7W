/* Write a program that gives you ten tries to guess a random number
 * from 1–100. If you would like, give a hint of “hotter” or “colder”
 * after the first guess
 */

// step 1 -- generate random number to start with
rng := Random clone
rng intValue := method(lower, upper,
                       base := self value
                       // this is not completely uniform, but good enough.
                       ((base * (upper - lower)) + lower) round)
goal := rng intValue(1, 100)
guess := -1
tries := 0
"You have 10 tries to guess a number between 1 and 100." println
"After the first, you will get a hint." println
while(goal != guess and tries != 10,
      if (tries == 1,
          if(guess < goal,
              writeln("hotter"), writeln("colder")))
      "#{10 - tries} tries left. Guess!" interpolate println
      guess = File standardInput readLine asNumber
      tries = tries + 1
)
if(goal == guess,
   "you won!" println,
   "you lost!" println)
