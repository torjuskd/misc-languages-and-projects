#lang racket
(define (incList L)
  (if(null? L) null
     (cons(+ 1 (car L))
(incList (cdr L)))))

(incList '(2 3 4 5))
(incList '())

(define (myApnd L1 L2)
  (if(null? L1) L2
     (cons(car L1)
(myApnd(cdr L1) L2))))

(myApnd '(2 3 4 5) '(6 7))

;Does not work:
(define (myReverse L)
  (if(null? L) null
(cons (myReverse (cdr L))
      (car L))))

(myReverse '(8 9 7 6 5))

(define (square a)
  (* a a)
  )
(define (squareRoot a)
  a ;finish later
  )

(define (quadratic_solution a b c)
  (define discriminant (- (square b) (*(* a c ) 4)))
  (if (< discriminant 0) "No real solution"
       (list(/ (- (sqrt discriminant) b) (* 2 a)) 
          (/ (- (- 0 (sqrt discriminant)) b) (* 2 a))) ))

(quadratic_solution 1 5 -6)

(define (solve-quadratic-equation a b c)
  (define disc (sqrt (- (* b b)
                        (* 4.0 a c))))
  (/ (+ (- b) disc)
     (* 2.0 a)))