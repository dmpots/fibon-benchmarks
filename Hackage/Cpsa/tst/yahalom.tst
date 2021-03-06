(comment "CPSA 2.1.0")
(comment "All input read")

(defprotocol yahalom basic
  (defrole init
    (vars (a b c name) (n-a n-b text) (k skey))
    (trace (send (cat a n-a)) (recv (enc b k n-a n-b (ltk a c)))
      (send (enc n-b k))))
  (defrole resp
    (vars (b a c name) (n-a n-b text) (k skey))
    (trace (recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))))
  (defrole serv
    (vars (c a b name) (n-a n-b text) (k skey))
    (trace (recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k n-a n-b (ltk a c))) (send (enc a k (ltk b c))))
    (uniq-orig k)))

(defskeleton yahalom
  (vars (n-b n-a text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b)
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))))
  (label 0)
  (unrealized (0 2) (0 3))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (precedes ((1 2) (0 2)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-strand serv 3) (enc a k (ltk b c))
    (0 2))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c)))
      (send (enc a k (ltk b c)))))
  (label 1)
  (parent 0)
  (unrealized (0 3) (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (precedes ((1 2) (0 2)) ((2 1) (1 0)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-strand resp 2)
    (enc a n-a-0 n-b-0 (ltk b c)) (1 0))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c))))))
  (label 2)
  (parent 1)
  (unrealized (0 3))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 n-a-1 text) (a b c a-0 b-0 c-0 name)
    (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (defstrand init 3 (n-a n-a-1) (n-b n-b) (a a-0) (b b-0) (c c-0) (k k))
  (precedes ((0 1) (3 1)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 1) (1 0))
    ((3 2) (0 3)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-strand init 3) (enc n-b k) (0 3))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((send (cat a-0 n-a-1)) (recv (enc b-0 k n-a-1 n-b (ltk a-0 c-0)))
      (send (enc n-b k))))
  (label 3)
  (parent 2)
  (unrealized (3 1))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (deflistener k)
  (precedes ((1 1) (3 0)) ((1 2) (0 2)) ((2 1) (1 0)) ((3 1) (0 3)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-listener k) (enc n-b k) (0 3))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((recv k) (send k)))
  (label 4)
  (parent 2)
  (unrealized (0 3) (3 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 n-a-1 text) (a b c a-0 b-0 c-0 name)
    (k k-0 skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (defstrand init 3 (n-a n-a-1) (n-b n-b) (a a-0) (b b-0) (c c-0) (k k))
  (defstrand serv 2 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k-0))
  (precedes ((0 1) (4 0)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 1) (1 0))
    ((3 2) (0 3)) ((4 1) (3 1)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k k-0)
  (operation nonce-test (added-strand serv 2) n-b (3 1)
    (enc a n-a n-b (ltk b c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((send (cat a-0 n-a-1)) (recv (enc b-0 k n-a-1 n-b (ltk a-0 c-0)))
      (send (enc n-b k)))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k-0 n-a n-b (ltk a c)))))
  (label 5)
  (parent 3)
  (unrealized (3 1))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (deflistener k)
  (precedes ((1 2) (0 2)) ((1 2) (3 0)) ((2 1) (1 0)) ((3 1) (0 3)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation nonce-test (added-strand serv 3) k (3 0)
    (enc b k n-a-0 n-b-0 (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((recv k) (send k)))
  (label 6)
  (parent 4)
  (unrealized (0 3) (3 0))
  (comment "empty cohort"))

(defskeleton yahalom
  (vars (n-a n-b text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k))
  (precedes ((0 1) (1 0)) ((1 1) (2 1)) ((1 2) (0 2)) ((2 2) (0 3)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation nonce-test
    (contracted (n-b-0 n-b) (n-a-0 n-a) (k-0 k) (a-0 a) (b-0 b) (c-0 c)
      (n-a-1 n-a)) n-b (3 1) (enc a n-a n-b (ltk b c))
    (enc b k n-a n-b (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k n-a n-b (ltk a c))) (send (enc a k (ltk b c))))
    ((send (cat a n-a)) (recv (enc b k n-a n-b (ltk a c)))
      (send (enc n-b k))))
  (label 7)
  (parent 5)
  (unrealized)
  (shape))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 n-a-1 text) (a b c a-0 b-0 c-0 name)
    (k k-0 skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (defstrand init 3 (n-a n-a-1) (n-b n-b) (a a-0) (b b-0) (c c-0) (k k))
  (defstrand serv 2 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k-0))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k-0))
  (precedes ((0 1) (4 0)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 1) (1 0))
    ((3 2) (0 3)) ((4 1) (5 1)) ((5 2) (3 1)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k k-0)
  (operation nonce-test (added-strand init 3) n-b (3 1)
    (enc a n-a n-b (ltk b c)) (enc b k-0 n-a n-b (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((send (cat a-0 n-a-1)) (recv (enc b-0 k n-a-1 n-b (ltk a-0 c-0)))
      (send (enc n-b k)))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k-0 n-a n-b (ltk a c))))
    ((send (cat a n-a)) (recv (enc b k-0 n-a n-b (ltk a c)))
      (send (enc n-b k-0))))
  (label 8)
  (parent 5)
  (unrealized (3 1))
  (comment "2 in cohort - 2 not yet seen"))

(defskeleton yahalom
  (vars (n-a n-b text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k))
  (precedes ((0 1) (1 0)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 2) (0 3))
    ((3 2) (2 1)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation nonce-test
    (contracted (n-b-0 n-b) (n-a-0 n-a) (k-0 k) (a-0 a) (b-0 b) (c-0 c)
      (n-a-1 n-a)) n-b (3 1) (enc n-b k) (enc a n-a n-b (ltk b c))
    (enc b k n-a n-b (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k n-a n-b (ltk a c))) (send (enc a k (ltk b c))))
    ((send (cat a n-a)) (recv (enc b k n-a n-b (ltk a c)))
      (send (enc n-b k)))
    ((send (cat a n-a)) (recv (enc b k n-a n-b (ltk a c)))
      (send (enc n-b k))))
  (label 9)
  (parent 8)
  (seen 7)
  (unrealized)
  (comment "1 in cohort - 0 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 n-a-1 text) (a b c a-0 b-0 c-0 name)
    (k k-0 skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (defstrand init 3 (n-a n-a-1) (n-b n-b) (a a-0) (b b-0) (c c-0) (k k))
  (defstrand serv 2 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k-0))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k-0))
  (deflistener k-0)
  (precedes ((0 1) (4 0)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 1) (1 0))
    ((3 2) (0 3)) ((4 1) (5 1)) ((4 1) (6 0)) ((5 2) (3 1))
    ((6 1) (3 1)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k k-0)
  (operation nonce-test (added-listener k-0) n-b (3 1) (enc n-b k-0)
    (enc a n-a n-b (ltk b c)) (enc b k-0 n-a n-b (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((send (cat a-0 n-a-1)) (recv (enc b-0 k n-a-1 n-b (ltk a-0 c-0)))
      (send (enc n-b k)))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k-0 n-a n-b (ltk a c))))
    ((send (cat a n-a)) (recv (enc b k-0 n-a n-b (ltk a c)))
      (send (enc n-b k-0))) ((recv k-0) (send k-0)))
  (label 10)
  (parent 8)
  (unrealized (3 1) (6 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 n-a-1 text) (a b c a-0 b-0 c-0 name)
    (k k-0 skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (defstrand init 3 (n-a n-a-1) (n-b n-b) (a a-0) (b b-0) (c c-0) (k k))
  (defstrand init 3 (n-a n-a) (n-b n-b) (a a) (b b) (c c) (k k-0))
  (deflistener k-0)
  (defstrand serv 3 (n-a n-a) (n-b n-b) (c c) (a a) (b b) (k k-0))
  (precedes ((0 1) (6 0)) ((1 1) (3 1)) ((1 2) (0 2)) ((2 1) (1 0))
    ((3 2) (0 3)) ((4 2) (3 1)) ((5 1) (3 1)) ((6 1) (4 1))
    ((6 2) (5 0)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k k-0)
  (operation nonce-test (added-strand serv 3) k-0 (6 0)
    (enc b k-0 n-a n-b (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c)))))
    ((send (cat a-0 n-a-1)) (recv (enc b-0 k n-a-1 n-b (ltk a-0 c-0)))
      (send (enc n-b k)))
    ((send (cat a n-a)) (recv (enc b k-0 n-a n-b (ltk a c)))
      (send (enc n-b k-0))) ((recv k-0) (send k-0))
    ((recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k-0 n-a n-b (ltk a c)))
      (send (enc a k-0 (ltk b c)))))
  (label 11)
  (parent 10)
  (unrealized (3 1) (5 0))
  (comment "empty cohort"))

(comment "Nothing left to do")

(defprotocol yahalom basic
  (defrole init
    (vars (a b c name) (n-a n-b text) (k skey))
    (trace (send (cat a n-a)) (recv (enc b k n-a n-b (ltk a c)))
      (send (enc n-b k))))
  (defrole resp
    (vars (b a c name) (n-a n-b text) (k skey))
    (trace (recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))))
  (defrole serv
    (vars (c a b name) (n-a n-b text) (k skey))
    (trace (recv (cat b (enc a n-a n-b (ltk b c))))
      (send (enc b k n-a n-b (ltk a c))) (send (enc a k (ltk b c))))
    (uniq-orig k)))

(defskeleton yahalom
  (vars (n-b n-a text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (deflistener k)
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b)
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k)))
    ((recv k) (send k)))
  (label 12)
  (unrealized (0 2) (0 3))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (deflistener k)
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (precedes ((2 1) (1 0)) ((2 2) (0 2)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-strand serv 3) (enc a k (ltk b c))
    (0 2))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))) ((recv k) (send k))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c)))
      (send (enc a k (ltk b c)))))
  (label 13)
  (parent 12)
  (unrealized (0 3) (1 0) (2 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (deflistener k)
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (precedes ((2 1) (1 0)) ((2 2) (0 2)) ((3 1) (2 0)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation encryption-test (added-strand resp 2)
    (enc a n-a-0 n-b-0 (ltk b c)) (2 0))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))) ((recv k) (send k))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c))))))
  (label 14)
  (parent 13)
  (unrealized (0 3) (1 0))
  (comment "1 in cohort - 1 not yet seen"))

(defskeleton yahalom
  (vars (n-b n-a n-a-0 n-b-0 text) (a b c name) (k skey))
  (defstrand resp 4 (n-a n-a) (n-b n-b) (b b) (a a) (c c) (k k))
  (deflistener k)
  (defstrand serv 3 (n-a n-a-0) (n-b n-b-0) (c c) (a a) (b b) (k k))
  (defstrand resp 2 (n-a n-a-0) (n-b n-b-0) (b b) (a a) (c c))
  (precedes ((2 2) (0 2)) ((2 2) (1 0)) ((3 1) (2 0)))
  (non-orig (ltk a c) (ltk b c))
  (uniq-orig n-b k)
  (operation nonce-test (added-strand serv 3) k (1 0)
    (enc b k n-a-0 n-b-0 (ltk a c)))
  (traces
    ((recv (cat a n-a)) (send (cat b (enc a n-a n-b (ltk b c))))
      (recv (enc a k (ltk b c))) (recv (enc n-b k))) ((recv k) (send k))
    ((recv (cat b (enc a n-a-0 n-b-0 (ltk b c))))
      (send (enc b k n-a-0 n-b-0 (ltk a c))) (send (enc a k (ltk b c))))
    ((recv (cat a n-a-0)) (send (cat b (enc a n-a-0 n-b-0 (ltk b c))))))
  (label 15)
  (parent 14)
  (unrealized (0 3) (1 0))
  (comment "empty cohort"))

(comment "Nothing left to do")
