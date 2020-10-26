(define (isPrime n)
  (define (*p i)
    (or (>= i n)
      (and (> (modulo n i) 0)
        (*p (+ i 1)))))
  (and (> n 1) (*p 2)))

(let loop ((i 1) (found 0))
  (or (>= found 3333)
    (loop
      (+ i 1)
      (if (isPrime i) (+ 1 found) found))))
