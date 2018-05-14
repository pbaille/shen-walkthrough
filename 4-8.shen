\\ 4. Lists

(do syntax-access

    [1 b (+ 1 2) [3 [9 a]]]

    (cons 1 [])

    (cons a (cons b (cons c [4 5 6])))

    [a b c | [4 5 6]]              \\ shorthand syntax

    (hd [a b c])
    (tl [a b c])

    \\ dotted pairs

    [a | b]

    (cons a b))

(do assoc-lists

 [[a | 1] [b | 2]]

 (define traverse
   _ [] -> not-found
   K [[K | V] | _] -> V
   K [_ | T] -> (traverse K T))

 (traverse a [[a | 1] [b | 2]]))

(do list-destructuring
 (define pairs
   A [] -> []
   A [X | Xs] -> (cons [A | X] (pairs A Xs)))

 (define cartesian-prod
   [] _ -> []
   [A | As] Bs -> (append (pairs A Bs) (cartesian-prod As Bs)))

 (cartesian-prod [1 2 3] [a b])

 (define powerset
   [] -> [[]]
   [X | Xs] -> (let P (powerset Xs)
                 (append (subsets X P) P)))

 (define subsets
   _ [] -> []
   X [Y | Z] -> [[X | Y] | (subsets X Z)])

 (powerset [a b c d]))

(let A 1
     B 2
     C 3
  (+ A B C))

(do goldbach-redo

 (define goldbachs-conjecture
   \\ begin with 4 and the list of primes < 4
   start -> (goldbachs-conjecture-help 4 [3 2]))

 (define goldbachs-conjecture-help
   N Primes -> N where (not (sum-of-two? Primes N))
   N Primes -> (if (prime? (+ N 1))
                   (goldbachs-conjecture-help (+ N 2) [(+ 1 N) | Primes])
                   (goldbachs-conjecture-help (+ N 2) Primes)))

 (define sum-of-two?
   \\ no primes left? then return false
   H _ -> false
   \\ \f the X + any other prime = N return true
   [X | Primes] N -> true where (x+prime=n X [X | Primes] N)
   \* no? then recurse. *\
   [_ | Primes] N -> (sum-of-two? Primes N))

 (define x+prime=n
   \\ no primes left, return false
   _ [ ] _ -> false
   \\ X + the first prime = N?, so return true
   X [Prime | _] N -> true where (= (+ X Prime) N) \\ recurse and to/ the other primes
   X [_ | Primes] N -> (x+prime=n X Primes N))
 )

\\ Strings

(do basics

 (string? "aaa")                \\ true
 (str aze)                      \\ "aze"
 (str "a")                      \\ ""a""
 (intern "aze")                 \\ aze


 \\ concat
 (cn "Hello" " World")
 (@s "H" "ell" "o " "you" "!")

 \\ access
 (pos "aze" 2) \\ "e"
 (pos "hi" 0) \\ "h"
 (tlstr "hize") \\ "ize"


  \\ chars
 "c#16;"
 (string->n "λ")
 (n->string 67)

 \\ templating
 (make-string "~A et ~A et ~% ~A oups..." 1 2 3)
 (make-string "~A a dit: ~S " "Bob" "Bonjour")
 (make-string "~A a dit: ~S " Bob Bonjour)
 (make-string "~R + ~R = ~A" [1 + 1] [2 + 3] [4 + 5])

 \\ read
 (read-from-string "[2 (+ 1 1)]")

 \\ pattern matching
 (define str-prefix?
   "" _ -> true
   (@s X Xs) (@s X Ys) -> (str-prefix? Xs Ys)
   _ _ -> false)

 (str-prefix? "123" "1234")
 (str-prefix? "123" "124"))

(do exploding 
 (explode [1 2 3])
 (explode "slurp")
 (explode aze)

 \\ exploding at read time
 ($ aze)

 (define yo
   [($ aze) | X] -> X)
 \\ equiv
 (define yo
   ["a" "z" "e" | X] -> X)
 )

(define double X -> (+ X X))

\\ Higher Order P

(do
    \\ lisp 2
    (map (function double) [2 4 6])

    (map (/. X (+ X X)) [1 2 3])

    \\ lambdas are curried
    (((/. X Y (+ X Y)) 1) 3)

    \\ error no destructuring on lamddas
    ((/. [X | Xs] Xs) [1 2 3])

    \\ yeah
    (map (+ 5) [1 2 3])

    \\ woo 
    (define addn-map
      N L -> (map (+ N) L)))

\\ Assignements

(do
 (set A 0)
 (value A)
 (+ (value A) 1)
 (value A)
 (set A 10)
 (set F (/. X (+ 1 X)))
 ((value F) 1))

