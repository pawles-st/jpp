(defun binomial (n k)
  (if (or (= k 0) (= k n))
    1
    (+
      (binomial (- n 1) k)
      (binomial (- n 1) (- k 1))
      )
    )
  )

(defun binomial2 (n k)
  (labels (
	   (pascal (n)
	     (if (= n 0)
	       '(1)
	       (let (
		     (prev_row (pascal (- n 1)))
		     )
		 (cons 1
		       (append
			 (mapcar #'+ (butlast prev_row) (rest prev_row))
			 '(1)
			 )
		       )
		 )
	       )
	     )
	   )
    (nth k (pascal n))
    )
  )

(defun mergesort (lst)
  (labels (
	   (mergelists (list1 list2)
	     (cond
	       ((null list1) list2)
	       ((null list2) list1)
	       ((< (car list1) (car list2))
		(cons (car list1) (mergelists (cdr list1) list2))
		)
	       (t
		 (cons (car list2) (mergelists list1 (cdr list2)))
		 )
	       )
	     )
	   )
    (let* (
	   (len (length lst))
	   (mid (floor len 2))
	   (left (subseq lst 0 mid))
	   (right (subseq lst mid))
	   )
      (if (< len 2)
	lst
	(mergelists (mergesort left) (mergesort right))
	)
      )
    )
  )

(defun de (a b)
  (if (= b 0)
    (list 1 0 a)
    (let* (
	   (q (floor a b))
	   (r (mod a b))
	   (prev (de b r))
	   )
      (list
	(cadr prev)
	(-
	  (car prev)
	  (* q (cadr prev))
	  )
	(caddr prev)
	)
      )
    )
  )

(defun prime_factors (n)
  (labels (
	   (factor (n d)
		   (cond
		     ((= n 1) '())
		     ((= (mod n d) 0)
		      (cons
			d
			(factor (/ n d) d)
			)
		      )
		     (t (factor n (+ d 1)))
		     )
		   )
	   )
    (factor n 2)
    )
  )

(defun totient (n)
  (labels (
	   (range (n)
		  (if (= n 1)
		    '(1)
		    (cons n (range (- n 1))))
		    )
	   (is_divisible (k)
			 (if (= (gcd n k) 1)
			   1
			   0
			   )
			 )
	   )
    (reduce #'+ (mapcar #'is_divisible (range n))
      )
    )
  )

(defun totient2 (n)
  (labels (
	   (subtract_one (lst)
		      (cond
			((null lst) nil)
			((or (null (cdr lst)) (< (car lst) (cadr lst)))
			 (cons (- (car lst) 1) (subtract_one (cdr lst)))
			 )
			(t (cons (car lst) (subtract_one (cdr lst))))
			)
		      )
	   )
    (reduce #'* (subtract_one (prime_factors n)))
    )
  )

(defun primes (n)
  (labels (
	   (range (start end)
		  (if (> start end)
		    nil
		    (cons start (range (+ start 1) end))
		    )
		  )
	   (sieve (lst)
		  (if (null lst)
		    nil
		    (let (
			  (p (car lst))
			  (remaining (cdr lst))
			  )
		      (
		       cons p (sieve (remove-if #'(lambda (x) (= (mod x p) 0)) remaining))
		       )
		      )
		    )
		  )
	   )
    (sieve (range 2 n))
    )
  )

(write (binomial 7 3))
(terpri)
(write (binomial2 7 3))
(terpri)
(write (mergesort '(9 8 7 6 5 4 3 2 1)))
(terpri)
(write (de 27 15))
(terpri)
(write (prime_factors 123))
(terpri)
(write (totient 123))
(terpri)
(write (totient2 123))
(terpri)
(write (primes 123))
(terpri)
