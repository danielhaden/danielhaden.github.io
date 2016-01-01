#lang racket

(require pollen/decode
         pollen/world       ; For world:current-poly-target
         txexpr
         pollen/tag
         pollen/template
         pollen/pagetree
         racket/date
         libuuid)            ; for uuid-generate

; We want srfi/13 for string-contains but need to avoid collision between
; its string-replace function and the one in racket/string
(require (only-in srfi/13 string-contains))

(provide add-between
         attr-ref
         attrs-have-key?
         make-txexpr
         string-contains)
(provide (all-defined-out))

(module config racket/base
    (provide (all-defined-out))
    (define poly-targets '(html ltx pdf)))

(define (root . elements)
  (case (world:current-poly-target)
    [(ltx pdf)
     (make-txexpr 'body null
                   (decode-elements elements
                                    ;#:txexpr-elements-proc detect-paragraphs
                                    #:inline-txexpr-proc (compose1 txt-decode hyperlink-decoder)
                                    #:string-proc (compose1 smart-quotes smart-dashes)
                                    #:exclude-tags '(script style figure)))]

    [else
      (make-txexpr 'body null
                   (decode-elements elements
                                    #:txexpr-elements-proc (compose1 detect-paragraphs splice)
                                    #:inline-txexpr-proc hyperlink-decoder
                                    #:string-proc (compose1 smart-quotes smart-dashes)
                                    #:exclude-tags '(script style figure)))]))

#|
`splice` lifts the elements of an X-expression into its enclosing X-expression.
|#
(define (splice xs)
  (define tags-to-splice '(splice-me))
  (apply append (for/list ([x (in-list xs)])
                  (if (and (txexpr? x) (member (get-tag x) tags-to-splice))
                      (get-elements x)
                      (list x)))))

#|
`txt` is called by root when targeting LaTeX/PDF. It converts all elements inside
a ◊txt tag into a single concatenated string. ◊txt is not intended to be used in
normal markup; its sole purpose is to allow other tag functions to return LaTeX
code as a valid X-expression rather than as a string.
|#
(define (txt-decode xs)
    (if (eq? 'txt (get-tag xs))
        (apply string-append (get-elements xs))
        xs))

#|
◊numbered-note, ◊margin-figure, ◊margin-note:
  These three tag functions produce markup for "sidenotes" in HTML and LaTeX.
  In our LaTeX template, any hyperlinks also get auto-converted to numbered
  sidenotes, which is kinda neat. Unfortunately, this also means that when
  targeting LaTeX, you can't have a hyperlink inside a sidenote since that would
  equate to a sidenote within a sidenote, which causes Problems.

  We handle this by not using a normal tag function for hyperlinks. Instead,
  within these three tag functions we call decode-elements to filter out any
  hyperlinks inside these tags (for LaTeX/PDF only). Then the root function uses
  a separate decoder to properly handle any hyperlinks that sit outside any of
  these three tags.
|#

(define (numbered-note . text)
    (define refid (uuid-generate))
    (case (world:current-poly-target)
      [(ltx pdf)
       (define cleantext (decode-elements text #:inline-txexpr-proc latex-no-hyperlinks-in-margin))
       `(txt "\\footnote{" ,@cleantext "}")]
      [else
        `(splice-me (label [[for ,refid] [class "margin-toggle sidenote-number"]])
                    (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
                    (span [(class "sidenote")] ,@text))]))

(define (margin-figure source . caption)
    (define refid (uuid-generate))
    (case (world:current-poly-target)
      [(ltx pdf)
       (define cleantext
               (decode-elements (make-txexpr 'tag null caption)
                                #:inline-txexpr-proc latex-no-hyperlinks-in-margin))
       `(txt "\\begin{marginfigure}"
             "\\includegraphics{" ,source "}"
             "\\caption{" ,@cleantext "}"
             "\\end{marginfigure}")]
      [else
        `(splice-me (label [[for ,refid] [class "margin-toggle"]] 8853)
                    (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
                    (span [[class "marginnote"]] (img [[src ,source]]) ,@caption))]))

(define (margin-note . text)
    (define refid (uuid-generate))
    (case (world:current-poly-target)
      [(ltx pdf)
       (define cleantext
               (decode-elements text #:inline-txexpr-proc latex-no-hyperlinks-in-margin))
       `(txt "\\marginnote{" ,@cleantext "}")]
      [else
        `(splice-me (label [[for ,refid] [class "margin-toggle"]] 8853)
                    (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
                    (span [[class "marginnote"]] ,@text))]))

#|
  This function is called from within the margin/sidenote functions when
  targeting Latex/PDF, to filter out hyperlinks from within those tags.
  (See notes above)
|#
(define (latex-no-hyperlinks-in-margin inline-tx)
  (if (eq? 'hyperlink (get-tag inline-tx))
    `(txt ,@(cdr (get-elements inline-tx))) ; Return the text contents only
    inline-tx)) ; otherwise pass through unchanged

(define (hyperlink-decoder inline-tx)
  (define (hyperlinker url . words)
    (case (world:current-poly-target)
      [(ltx pdf) `(txt "\\href{" ,url "}" "{" ,@words "}")]
      [else `(a [[href ,url]] ,@words)]))

  (if (eq? 'hyperlink (get-tag inline-tx))
      (apply hyperlinker (get-elements inline-tx))
      inline-tx))

(register-block-tag 'pre)
(register-block-tag 'figure)
(register-block-tag 'center)
(register-block-tag 'blockquote)

(define (p . words)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt ,@words)]
    [else `(p ,@words)]))

(define (newthought . words)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\newthought{" ,@words "}")]
    [else `(span [[class "newthought"]] ,@words)]))

(define (smallcaps . words)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\textsc{" ,@words "}")]
    [else `(span [[class "smallcaps"]] ,@words)]))

(define (center . words)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\begin{center}" ,@words "\\end{center}")]
    [else `(div [[style "text-align: center"]] ,@words)]))

(define (doc-section title . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\section*{" ,title "}" ,@text)]
    [else `(section (h2 ,title) ,@text)]))

(define (index-entry entry . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\index{" ,entry "}" ,@text)]
    [else
      (case (apply string-append text)
        [("") `(a [[id ,entry] [class "index-entry"]])]
        [else `(a [[id ,entry] [class "index-entry"]] ,@text)])]))

(define (figure source . caption)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\begin{figure}"
                     "\\includegraphics{" ,source "}"
                     "\\caption{" ,caption "}"
                     "\\end{figure}")]
    [else `(figure (img [[src ,source]]) (figcaption ,@caption))]))

(define (fullwidthfigure source . caption)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\begin{figure}"
                     "\\includegraphics[width=\\linewidth]{" ,source "}"
                     "\\caption{" ,caption "}"
                     "\\end{figure}")]
    [else `(figure [[class "fullwidth"]] (img [[src ,source] [alt ,@caption]]) (figcaption ,@caption))]))

(define (code . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\texttt{" ,@text "}")]
    [else `(span [[class "code"]] ,@text)]))

(define (blockcode . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\begin{verbatim}" ,@text "\\end{verbatim}")]
    [else `(pre [[class "code"]] ,@text)]))

; In HTML these two tags won't look much different. But when outputting to
; LaTeX, ◊i will italicize multiple blocks of text, where ◊emph should be
; used for words or phrases that are intended to be emphasized. In LaTeX,
; if the surrounding text is already italic then the emphasized words will be
; non-italicized.
(define (i . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "{\\itshape " ,@text "}")]
    [else `(i ,@text)]))

(define (emph . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\emph{" ,@text "}")]
    [else `(em ,@text)]))

#|
Typesetting poetry in LaTeX or HTML. HTML uses a straightforward <pre> with
appropriate CSS. In LaTeX we explicitly specify the longest line for centering
purposes, and replace double-spaces with \vin to indent lines.
|#
(define verse
    (lambda (#:title [title ""] #:italic [italic #f] . text)
     (case (world:current-poly-target)
      [(ltx pdf)
       (define poem-title (if (non-empty-string? title)
                              (apply string-append `("\\poemtitle{" ,title "}"))
                              ""))

       ; Replace double spaces with "\vin " to indent lines
       (define poem-text (string-replace (apply string-append text) "  " "\\vin "))

       ; Optionally italicize poem text
       (define fmt-text (if italic (format "{\\itshape ~a}" (latex-poem-linebreaks poem-text))
                                   (latex-poem-linebreaks poem-text)))

       `(txt "\n\n" ,poem-title
             "\n\\settowidth{\\versewidth}{"
             ,(longest-line poem-text)
             "}"
             "\n\\begin{verse}[\\versewidth]"
             ,fmt-text
             "\\end{verse}\n\n")]
      [else
        `(div [[class "poem"]]
              (pre [[class "verse"]]
                   (p [[class "poem-heading"]] ,title)
                   ,@text))])))

#|
Helper function for typesetting poetry in LaTeX. Poetry should be centered
on the longest line. Browsers will do this automatically with proper CSS but
in LaTeX we need to tell it what the longest line is.
|#
(define (longest-line str)
  (first (sort (string-split str "\n")
               (λ(x y) (> (string-length x) (string-length y))))))

(define (latex-poem-linebreaks text)
  (regexp-replace* #px"([^[:space:]])\n(?!\n)" ; match newlines that follow non-whitespace
                                               ; and which are not followed by another newline
                   text
                   "\\1 \\\\\\\\\n"))

(define (grey . text)
  (case (world:current-poly-target)
    [(ltx pdf) `(txt "\\textcolor{gray}{" ,@text "}")]
    [else `(span [[style "color: #777"]] ,@text)]))

(define (list-posts-in-series s)
    (define (make-li post)
      `(li (a [[href ,(symbol->string post)]]
              (i ,(select-from-metas 'title post))) " by " ,(select-from-metas 'author post)))

    `(ul ,@(filter identity
                   (map (λ(post)
                          (if (equal? s (string->symbol (select-from-metas 'series post)))
                              (make-li post)
                              #f))
                        (children 'posts.html)))))

#|
Index functionality: allows creation of a book-style keyword index.

* An index ENTRY refers to the heading that will appear in the index.
* An index LINK is a txexpr that has class="index-entry" and
  id="ENTRY-WORD". (Created in docs with the ◊index-entry tag above)

|#

; Returns a list of all elements in xpr that have class="index-entry"
; and an id key.
(define (filter-index-entries xpr)
  (define is-index-entry? (λ(x) (and (txexpr? x)
                                     (attrs-have-key? x 'class)
                                     (attrs-have-key? x 'id)
                                     (equal? "index-entry" (attr-ref x 'class)))))
  (let-values ([(x y) (splitf-txexpr xpr is-index-entry?)]) y))

; Given a file, returns a list of links to each index entry within that file
(define (get-index-links file)
  (define file-body (select-from-doc 'body file))
  (if file-body
      (map (λ(x)
             `(a [[href ,(string-append (symbol->string file) "#" (attr-ref x 'id))]
                  [id ,(attr-ref x 'id)]]
                 ,(select-from-metas 'title file)))
           (filter-index-entries (make-txexpr 'div '() file-body)))
      ; return a dummy entry when `file` has no 'body (for debugging)
      (list `(a [[class "index-entry"] [id ,(symbol->string file)]]
                "Not a txexpr: " ,(symbol->string file)))))

; Returns a list of index links (not entries!) for all files in file-list.
(define (collect-index-links file-list)
  (apply append (map get-index-links file-list)))

; Given a list of index links, returns a list of headings (keywords). This list
; has duplicates removed and is sorted in ascending alphabetical order.
; Note that the list is case-sensitive by design; "thing" and "Thing" are
; treated as separate keywords.
(define (index-headings entrylink-list)
  (sort (remove-duplicates (map (λ(tx) (attr-ref tx 'id))
                                entrylink-list))
        string-ci<?))

; Given a heading and a list of index links, returns only the links that match
; the heading.((
(define (match-index-links keyword entrylink-list)
  (filter (λ(link)(string=? (attr-ref link 'id) keyword))
          entrylink-list))

; Modified from https://github.com/malcolmstill/mstill.io/blob/master/blog/pollen.rkt
; Converts a string "2015-12-19" or "2015-12-19 16:02" to string "Saturday, December 19th, 2015"
(define (datestring->date datetime)
  (match (string-split datetime)
    [(list date time) (match (map string->number (append (string-split date "-") (string-split time ":")))
                        [(list year month day hour minutes) (date->string (seconds->date (find-seconds 0
                                                                                                       minutes
                                                                                                       hour
                                                                                                       day
                                                                                                       month
                                                                                                       year)))])]
    [(list date) (match (map string->number (string-split date "-"))
                   [(list year month day) (date->string (seconds->date (find-seconds 0
                                                                                     0
                                                                                     0
                                                                                     day
                                                                                     month
                                                                                     year)))])]))