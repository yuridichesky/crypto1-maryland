;;
;; Vigenere cipher


(define *first-char* (char->integer #\a))
(define *last-char*  (char->integer #\z))

(define *size*       (+ 1 (- *last-char* *first-char*)))


(define (m->int m) (- (char->integer m) *first-char*))
(define (int->m i) (integer->char (+ i *first-char*)))


(define (vigenere-proc shift-proc key msg)
  (let loop ((msg (map m->int (string->list msg)))
             (key (apply circular-list (map m->int (string->list key))))
             (res '()))
    (if (null? msg) (list->string (map int->m (reverse res)))
      (loop (cdr msg) (cdr key) (cons (shift-proc (car msg) (car key)) res)))))


(define (vigenere-encrypt key msg)
  (vigenere-proc (lambda (m k) (remainder (+ m k) *size*)) key msg))


(define (vigenere-decrypt key msg)
  (vigenere-proc (lambda (m k) (if (>= m k) (- m k) (+ *size* (- m k)))) key msg))


;; end of file
