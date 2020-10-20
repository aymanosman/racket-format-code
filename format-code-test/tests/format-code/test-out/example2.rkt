#lang racket

(parameterize ([current-foo 42])
              (display (current-foo)))
