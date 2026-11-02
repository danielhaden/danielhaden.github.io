#lang racket/base
;; Tag functions for danielhaden.github.io.
;; Every function here is callable from a .pm source as ◊name{...}.
(require racket/list racket/string txexpr pollen/template pollen/core
         pollen/decode pollen/pagetree pollen/setup)
(provide (all-defined-out))

(module setup racket/base
  (require racket/path)
  (provide (all-defined-out))
  ;; Source files that `raco pollen publish` should leave out of the site.
  (define (unpublished-path? p)
    (define file (file-name-from-path p))  ; #f for a directory path such as "."
    (define name (and file (path->string file)))
    (and name
         (or (regexp-match? #rx"^\\." name)
             (and (member name '("template.html" "README.md" "LICENSE" "CLAUDE.md")) #t)))))

(define site-title "Daniel Haden")

;; ---------------------------------------------------------------------
;; Root: paragraphs and typography, leaving code untouched.

(define (root . elements)
  (txexpr 'root empty
          (decode-elements elements
                           #:txexpr-elements-proc decode-paragraphs
                           #:string-proc (compose1 smart-quotes smart-dashes)
                           #:exclude-tags '(pre code script))))

;; ---------------------------------------------------------------------
;; Markup

(define (slugify str)
  (string-trim (regexp-replace* #rx"[^a-z0-9]+" (string-downcase str) "-") "-"))

(define (plain-text xs)
  (string-append* (map (λ (x) (if (txexpr? x) (plain-text (get-elements x)) (format "~a" x))) xs)))

(define (section . xs)
  `(h2 ((id ,(slugify (plain-text xs)))) ,@xs))

;; ◊link["https://example.com"]{text}
(define (link url . xs)
  `(a ((href ,url)) ,@xs))

;; ---------------------------------------------------------------------
;; Navigation, built from index.ptree.

(define (site-pagetree)
  (get-pagetree (build-path (current-project-root) "index.ptree")))

(define (page-title page)
  (or (select-from-metas 'title (get-metas page)) (symbol->string page)))

;; Top navigation bar; marks the current page.
(define (site-nav here)
  (->html
   `(nav ((class "site-nav"))
         ,@(for/list ([page (in-list (pagetree->list (site-pagetree)))])
             `(a ((href ,(symbol->string page))
                  ,@(if (eq? page here) '((aria-current "page")) '()))
                 ,(page-title page))))))
