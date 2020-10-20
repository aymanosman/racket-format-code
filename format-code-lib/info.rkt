#lang info

(define collection "format-code")

(define deps '("base"))

(define raco-commands
  '(("format" format-code/cli "run the formatter" #f)))
