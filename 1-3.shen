\\ literals -------------------------------------------------

foo \\ symbol are not evaluated

1

"Bob"

\\ exprs ----------------------------------------------------

(+ 1 1)

(+ 1 1 (/ 2 3))

\\ repl -----------------------------------------------------

!1 \\ !n repeat the nth expr

!sym \\ repeat last expr strating with "sym"

%+ \\ list all previous exprs

\\ evaluation ----------------------------------------------

(do

 (if true
     (print "hello")
     (print "goodbye"))

 (if false
     (print "hello")
     (print "goodbye"))

 (cases
  (> 0 1) 1
  (< 1 0) 2
  true 3))

\\ bools --------------------------------------------------

true

false

(and true false)

(or (> 0 1) (= a a))

\\ functions ---------------------------------------------

(do

 \\ pattern match
 (define foo
   0 -> zero
   1 -> one
   _ -> positive)

 (foo 11)

 \\ errors tracking
 (define efn1
   0 -> ok)

 (define efn2
   _ -> (efn1 1))

 (efn2 0)

 \\variables
 (define mult
   _ 0 -> 0
   0 _ -> 0
   X 1 -> X
   1 X -> X
   X Y -> (+ X (mult X (- Y 1))))

 (mult 9999 9999)

 \\ unification in patterns
 (define same
   X X -> true
   X Y -> false)

 (same "aze" "aze")
 (same 2 3)

 \\ free varibles
 (define g X -> (+ X (protect Y)))

 )

\\ loading code ------------------------------------------

(load "one.shen")

(cd "~/Code/Shen/tut")

\\ recursion ---------------------------------------------

(do
 \\ linear recursion
 (define factorial1
   0 -> 1
   X -> (* X (factorial (- X 1))))

 (track factorial1)
 (factorial1 5)

 \\ tail recursion
 (define factorial2
   X -> (factorial2-h X 1))

 (define factorial2-h
   0 Acc -> Acc
   X Acc -> (factorial2-h (- X 1) (* X Acc)))

 (track factorial2-h)
 (factorial2 5)

 \\ linear
 (define plus-l
   X 0 -> X
   X Y -> (+ 1 (plus-l X (- Y 1))))
 \\ tail
 (define plus-t
   X 0 -> X
   X Y -> (plus-t (+ X 1) (- Y 1)))

 \\ tree recursion (call itself several times)
 (define fib
   0 -> 0
   1 -> 1
   X -> (+ (fib (- X 1)(- X 2))))

 \\ mutual recursion

 (define even?
   1 -> false
   X -> odd? (- X 1))

 (define odd?
   0 -> false
   X -> even? (- X 1)))

\\ Guards -----------------------------------------------

(do

 (define prime?
   X -> (prime-h? X (isqrt X) 2))

 (define isqrt
   X -> (isqrt-h X 1))

 (define isqrt-h
   X Y -> Y         where (= (* Y Y) X)
   X Y -> (- Y 1)   where (> (* Y Y) X)
   X Y -> (isqrt-h X (+ Y 1)))

 (define prime-h?
   X Max Div -> true     where (> Div Max)
   X Max Div -> false    where (integer? (/ X Div))
   X Max Div -> (prime-h? X Max (+ 1 Div)))

 (prime? 7))

\\ 3.6 Counting change ---------------------------------

(do

 (define count-change
   Amount -> (count-change-h Amount 200))

 (define count-change-h
   0 _ -> 1
   _ 0 -> 0
   Amount _ -> 0 where (> 0 Amount)
   Amount Fst_Denom
   -> (+ (count-change-h (- Amount Fst_Denom) Fst_Denom)
         (count-change-h Amount (next-denom Fst_Denom))))

 (define next-denom
   200 -> 100
   100 -> 50
   50 -> 20
   20 -> 10
   10 -> 5
   5 -> 2
   2 -> 1
   1 -> 0)

 (count-change 100)
 )

\\ 3.7 Non terminating functions ----------------------

(do

 (define slow-goldbachs-conjecture
   -> (slow-goldbachs-conjecture-h 4))

 (define slow-goldbachs-conjecture-h
   N -> (slow-goldbachs-conjecture-h (+ N 2)) where (sum-of-two-primes? N)
   N -> N)

 (define sum-of-two-primes?
   N -> (sum-of-two-primes-h? 2 N))

 (define sum-of-two-primes-h?
   P N -> false where (> P N)
   P N -> true where (sum-of? P 2 N)
   P N -> (sum-of-two-primes-h? (next-prime (+ 1 P)) N))

 (define sum-of?
   P1 P2 N -> true where (= N (+ P1 P2))
   P1 P2 N -> false where (> (+ P1 P2) N)
   P1 P2 N -> (sum-of? P1 (next-prime (+ 1 P2)) N))

 (define next-prime
   X -> X where (prime? X)
   X -> (next-prime (+ 1 X)))

 (next-prime 66))


