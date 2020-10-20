#lang racket

(require "formatter.rkt"
         raco/command-name)

(define --write (make-parameter #f))

(command-line
 #:program (short-program+command-name)
 #:once-each
 [("--write") "change files in place" (--write #t)]
 #:args (glob-string)
 (format-code glob-string #:write? (--write)))


