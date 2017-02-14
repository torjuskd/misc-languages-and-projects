#lang racket
(list-ref '((1 2 3 4) (2 4 5) (3 6) (4 3 6 7) (5 4 7) (6) (7 6)) 0)

;Depth-first search
(define (dfs L1) ; '(1 2 3 4)
  L1
  )

(define (findStart L1)
  (if (member (caar L1) (cdr L1)) (findStart (cdr L1))
      (caar L1) 
      )
  )

; topoSort - Topological sort 
; Reads a graph info represented by adjacency list as input parameter.
(define (topoSort L1)
  (if (member (findStart L1) (cdar L1)) "move to next node" ;move to next node
      (topoSort (cons (car L1) (list-tail L1 2))))
      )

(topoSort '((1 2 3 4) (2 4 5) (3 6) (4 3 6 7) (5 4 7) (6) (7 6)))
;result = '(1 2 5 4 3 7 6)