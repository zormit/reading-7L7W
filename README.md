Chapter 1 Ruby
==============

Day 1
-----

* Interesting: `unless.class` (and other keywords) will still "open a bracket" and only throw an error when you type "end".

### Find

* Ruby API
  * http://ruby-doc.org/core
  * find there for example the "times" method defined for Integers: http://ruby-doc.org/core-2.4.0/Integer.html#method-i-times
* The free online version of Programming Ruby -- http://ruby-doc.com/docs/ProgrammingRuby/
  * seems to be outdated though. Is there a free version of the third edition?
* A method that substitutes part of a string -- gsub / gsub! (inplace)
* Info about Ruby's regular expressions -- https://ruby-doc.org/core/Regexp.html
  * use `#match` or `=~` operator. "If a match is found, the operator returns index of first match in string, otherwise it returns nil."
* ~ about ranges -- https://ruby-doc.org/core-2.4.0/Range.html
  * can I build something like (feb..oct)? [yup.](1-ruby/month.rb)

### Do

* ``"Hello, Ruby".index("Ruby")``
* To load a file in IRB use `require './file.rb'`

Day 2
-----

* What's the difference between string and symbol, e.g. when using it as a key in a Hash?
* Is `:[]` a symbol as well?
* Did he talk about how a function call is taking place? I find the notation "without brackets" surprising from a Python view (not from a Haskell view though)
* what does `yield` do? Activate a codeblock? -- yes, seems right.
* Can we discuss the `pass_block` example?
* Understand Ruby metamodel (p. 42)
* `BasicObject` seems to be "new".
* Did you know that "Flavors" was a programming language? :) A LISP-Dialect.

Day 3
-----

* How can I prevent accidentally overriding an internal open class?
* Can I break ruby by exploiting open classes?
* "The API is so much easier: `Roman.i` versus `Roman.number_for "i"`". --> is this worth the "risk of breaking everything"?
* "You can literally implement `def` or `attr_accessor` with a few lines of code in a module." --> how? why?
* does `def self.X` define a class-method?

Chapter 2 Io
============

Day 1
-----

### Find

* Find some Io example problems
    * https://gist.github.com/jezen/7972975
    * https://github.com/kmein/euler-io
* An Io community that will answer questions
* A style guide with Io idioms
    * https://en.wikibooks.org/wiki/Io_Programming/Io_Style_Guide

### Answer

* Evaluate 1 + 1 and then 1 + "one" . Is Io strongly typed or weakly
typed? Support your answer with code.
    * https://www.destroyallsoftware.com/compendium/strong-and-weak-typing/6b0dd1ec18ab6102
    * I would say:
        * not static, as we can say `a := true` and then `a = 1`.
        * probably no implicit conversion: `1 + "1"`
        * probably memory safe and enforced rules.

* Is 0 true or false? What about the empty string? -- both true
* Is nil true or false? -- false
* How can you tell what slots a prototype supports? -- slotNames
* What is the difference between = (equals), := (colon equals), and ::=
(colon colon equals)? When would you use each one?
    * = needs a slot to put a value in.
    * := can create a slot
    * ::= creates slot, creates setter.
    * cf. http://iolanguage.org/guide/guide.html#Syntax-Assignment

### Do

* to run a file just "call it" like: `io 02-io/cars.io`
* to Execute the code in a slot given its name.
    * maybe they meant something like [`runSlot.io`](2-io/runSlot.io). But that does not look like it runs by slotname, rather it evaluates a string. Also, why is it `doString(...)` and not `... doString`?

Chapter 3 - Prolog
==================

Day 1
-----

### Do
* Find one reference for the Prolog version you’re using
    * `/usr/share/doc/gprolog-docs/`

Day 2
-----

* Why can't I type `concatenate([], List, List).` to the commandline?

### Do
* Find some implementations of a Fibonacci series and factorials.
  How do they work?
    * A, Fibonacci: http://www.cs.utexas.edu/~cannata/cs345/Class%20Notes/Prolog%20examples.pdf
    * A, Factorials: https://www.cpp.edu/~jrfisher/www/prolog_tutorial/2_2.html
        * TODO: Exercise at the bottom of Factorial.

Chapter 4 - Scala
=================

Day 1
-----
* "Unlike Ruby, all method definitions have parameter types and names." -- I don't understand this sentence (p. 148)
    * It is for example possible to remove the return type of a method.
    * But it is not possible to remove the type of a method parameter:
        ```
        scala> class Person(firstName)
        <console>:1: error: ':' expected but ')' found.
        class Person(firstName)
        ```
* I didn't understand how to make use of this "companion object", see [ring.scala](4-scala/ring.scala).

### Find

* The Scala API -- [here](https://www.scala-lang.org/api/current/)
* A comparison of Java and Scala -- I'm not so interested in that.
* A discussion of val versus var -- [here](https://sanaulla.info/2009/07/02/val-versus-var-in-scala-2/)

### Do

* Write a game that will take a tic-tac-toe board with X, O, and blank
characters and detect the winner or whether there is a tie or no
winner yet. Use classes where appropriate.
* Bonus problem: Let two players play tic-tac-toe.
