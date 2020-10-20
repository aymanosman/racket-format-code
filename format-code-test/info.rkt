#lang info

(define collection 'multi)

(define deps '("base" "format-code-lib"))

(define build-deps '("rackunit-lib"))

(define test-omit-paths (list "tests/format-code/test-out"
                              "integration-tests"))
