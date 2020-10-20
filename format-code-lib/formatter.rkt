#lang racket

(provide (contract-out [format-code (->* (path-string?) (#:write? boolean?) any)]))

(require framework
         file/glob)

(define (format-code pattern #:write? [write #f])
  (define paths (glob pattern))

  (when (empty? paths)
    (log-error (format "no files match pattern ~s" pattern))
    (exit 1))

  (define t (new racket:text%))

  (define (format-file f)
    (send t set-filename f)
    (send t load-file)
    (send t tabify-all))

  (for ([filename paths])
    (define-values (_results cpu-time real-time gc-time) (time-apply format-file (list filename)))
    (cond
      [write
       (send t save-file)
       (ansi-dim (cond
                   [(path? filename)
                    (path->string filename)]
                   [else
                    filename]))
       (printf " ~a ms" (~r #:precision 0 cpu-time))
       (newline)]
      [else
       (send t save-port (current-output-port))])))

(define (ansi-dim str)
  (printf "\e[2m~a\e[22m" str))

(define (log-error msg)
  (ansi-inverse-red " ERROR ")
  (eprintf "  ")
  (eprintf msg)
  (eprintf "\n"))

(define (ansi-inverse-red msg)
  (eprintf "\e[7m\e[31m~a\e[0m" msg))
