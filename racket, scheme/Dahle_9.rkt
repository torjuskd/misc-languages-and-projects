#lang racket
;Function "square" returns the square of input number
(define (square a)
  (* a a)
  )
;Function "quadratic_solution" returns solution(s) to input quadratic equation
(define (quadratic_solution a b c)
  ;Defining discriminant for later use
  (define discriminant (- (square b) (*(* a c ) 4)))
  ;If discriminant is negative, there will be no solutions:
  (if (< discriminant 0) "No real solution."
      ;Here we calculate and return the answers as a list
       (list(/ (- (sqrt discriminant) b) (* 2 a)) 
          (/ (- (- 0 (sqrt discriminant)) b) (* 2 a))) ))