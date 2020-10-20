#lang racket

(require rackunit
         racket/runtime-path)

(require format-code)

(define-runtime-path test-out "test-out")

(check-equal?
 (with-output-to-string
   (lambda ()
     (format-code (build-path test-out "example.rkt"))))

 (file->string (build-path test-out "example.rkt.out")))

(check-equal?
 (with-output-to-string
   (lambda ()
     (format-code (build-path test-out "example2.rkt"))))

 (file->string (build-path test-out "example2.rkt.out")))
