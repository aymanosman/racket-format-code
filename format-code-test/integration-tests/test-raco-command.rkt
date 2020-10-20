#lang racket

(require rackunit
         racket/runtime-path)

(define-runtime-path here ".")

(define filename (build-path here "identity.rkt"))

(check-equal?
 (let ()
   (match-define (list in out pid err interact) (process (format "raco format ~a" (path->string filename))))
   (port->string in))

 (file->string filename))
