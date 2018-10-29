#lang racket
(require csc151)

; User instructions
; 1. Choose 4 sets of two words that you want to finish each paragraph with
;    and put them into separate lists.
;    It is better if the two words you chose can make contextual sense when put together.
; 2. Find the filepath for the lyrics dataset csv file you want to use as a source.
;    (e.g.: /home/username/Desktop/billboard_lyrics.csv)
; 3. Designate the filepath onto which the procedure extracts the lyrics column of the source file.
;    (e.g.: /home/username/Desktop/billboard_lyrics.txt)
; 4. Run the procedure. It will take a few minutes until the lyrics are generated.
; 5. If the procedure runs into an error that looks like this, it means it could not find
;    phrases that precedes one of the input words. Please try with more generic set of words.
;     random: contract violation
;     expected: (or/c (integer-in 1 4294967087) pseudo-random-generator?)
;     given: 0


; USER WARNING:
; THE LYRICS MAY CONTAIN INAPPROPRIATE LANGUAGE.



;main procedures

;;; Procedure:
;;;   generate-lyrics
;;; Parameters:
;;;   end-words-verse1, a list of two strings
;;;   end-words-verse2, a list of two strings
;;;   end-words-chorus, a list of two strings
;;;   end-words-bridge, a list of two strings
;;;   source-filepath, a string which tells the location of the csv file
;;;   output-filepath, a string which tells the location of the txt file
;;;                    onto which generate-lyrics extracts the lyrics column from the source file
;;; Purpose:
;;;   to generate paragraphs in a song format
;;; Produces:
;;;   result, displayed list of strings
;;; Preconditions:
;;;   Each row of the csv file located in source-filepath is in the form of
;;;   (list rank:integer, song:string, artists:string, year:integer, lyrics:string, and source:string)
;;; Postconditions:
;;;   Each string displayed in result is also contained in the csv file located in source-filepath.
;;;   result has 31 lines, 9 paragraphs
(define generate-lyrics
  (lambda (end-words-verse1
           end-words-verse2
           end-words-chorus
           end-words-bridge
           source-filepath
           output-filepath)
    (let* ([lyrics-file (read-csv-file source-filepath)]
           [lyrics-column-vec
            (list->vector (map (r-s list-ref 4) lyrics-file))]
           [extract-lyrics (write-each-string lyrics-column-vec output-filepath)])
      (let ([verse1 (generate-paragraph end-words-verse1 output-filepath 8)]
            [verse2 (generate-paragraph end-words-verse2 output-filepath 8)]
            [half-chorus (generate-paragraph end-words-chorus output-filepath 2)]
            [bridge (generate-paragraph end-words-bridge output-filepath 3)])
        (display (reduce append (list verse1 (list #\newline)
                                      half-chorus (list #\newline) half-chorus (list #\newline)
                                      verse2 (list #\newline)
                                      half-chorus (list #\newline) half-chorus (list #\newline)
                                      bridge (list #\newline)
                                      half-chorus (list #\newline) half-chorus)))))))

; User instructions
; 1. Choose 4 sets of two words that you want to finish each paragraph with
;    and put them into separate lists.
;    It is better if the two words you chose can make contextual sense when put together.
;    For generate-lyrics-rhyme, the second word of each word pair
;    should be longer than three letters.
; 2. Find the filepath for the lyrics dataset csv file you want to use as a source.
;    (e.g.: /home/username/Desktop/billboard_lyrics.csv)
; 3. Designate the filepath onto which the procedure extracts the lyrics column of the source file.
;    (e.g.: /home/username/Desktop/billboard_lyrics.txt)
; 4. Run the procedure. It will take a few minutes until the lyrics are generated.
; 5. If the procedure runs into an error that looks like this, it means it could not find
;    phrases that precedes one of the input words. Please try with more generic set of words.
;     random: contract violation
;     expected: (or/c (integer-in 1 4294967087) pseudo-random-generator?)
;     given: 0

; USER WARNING:
; THE LYRICS MAY CONTAIN INAPPROPRIATE LANGUAGE.

;;; Procedure:
;;;   generate-lyrics-rhyme
;;; Parameters:
;;;   end-words-verse1, a list of two strings
;;;   end-words-verse2, a list of two strings
;;;   end-words-chorus, a list of two strings
;;;   end-words-bridge, a list of two strings
;;;   source-filepath, a string which tells the location of the csv file
;;;   output-filepath, a string which tells the location of the txt file
;;;                    onto which generate-lyrics-rhyme extracts song lyrics
;;; Purpose:
;;;   to generate paragraphs in a song format where the last words of each line rhymes
;;; Produces:
;;;   result, displayed list of strings
;;; Preconditions:
;;;   (> (string-length (cadr end-words-verse1)) 3)
;;;   (> (string-length (cadr end-words-verse2)) 3)
;;;   (> (string-length (cadr end-words-chorus)) 3)
;;;   (> (string-length (cadr end-words-bridge)) 3)
;;;   Each row of the csv file located in source-filepath is in the form of
;;;   (list rank:integer, song:string, artists:string, year:integer, lyrics:string, and source:string)
;;; Postconditions:
;;;   Each string displayed in result is also contained in the csv file located in source-filepath.
;;;   result has 31 lines, 9 paragraphs
(define generate-lyrics-rhyme
  (lambda (end-words-verse1
           end-words-verse2
           end-words-chorus
           end-words-bridge
           source-filepath
           output-filepath)
    (let* ([lyrics-file (read-csv-file source-filepath)]
           [lyrics-column-vec
            (list->vector (map (r-s list-ref 4) lyrics-file))]
           [extract-lyrics (write-each-string lyrics-column-vec output-filepath)])
      (let ([verse1 (generate-paragraph-rhyme end-words-verse1 output-filepath 8)]
            [verse2 (generate-paragraph-rhyme end-words-verse2 output-filepath 8)]
            [half-chorus (generate-paragraph-rhyme end-words-chorus output-filepath 2)]
            [bridge (generate-paragraph-rhyme end-words-bridge output-filepath 3)])
        (display (reduce append (list verse1 (list #\newline)
                                      half-chorus (list #\newline) half-chorus (list #\newline)
                                      verse2 (list #\newline)
                                      half-chorus (list #\newline) half-chorus (list #\newline)
                                      bridge (list #\newline)
                                      half-chorus (list #\newline) half-chorus)))))))

;helper procedures

;;; Procedure:
;;;   rhyme?
;;; Parameters:
;;;   str1, a string
;;;   str2, a string
;;; Purpose:
;;;   to compare the last three letters of str1 and str2 to check if they are equal or not
;;; Produces:
;;;   result, a boolean value  
(define rhyme?
  (lambda (str1 str2)
    (let* ([str1-length (string-length str1)]
           [str2-length (string-length str2)]
           [last-letter-str1 (- str1-length 1)]
           [last-letter-str2 (- str2-length 1)])
      (if (or (< str1-length 4)
              (< str2-length 4))
          #f
          (equal? (list (string-ref str1 (- last-letter-str1 2))
                        (string-ref str1 (- last-letter-str1 1))
                        (string-ref str1 last-letter-str1))
                  (list (string-ref str2 (- last-letter-str2 2))
                        (string-ref str2 (- last-letter-str2 1))
                        (string-ref str2 last-letter-str2)))))))

;;; Procedure:
;;;   generate-paragraph-rhyme
;;; Parameters:
;;;   end-words, a list of two strings
;;;   input-filepath, a string which tells the location of the txt file containing extracted lyrics
;;;   num-of-lines, a positive integer
;;; Purpose:
;;;   to create a paragraph of a string of words that has the last three letters of the last word of each line matching
;;; Produces:
;;;   result, a list of strings
(define generate-paragraph-rhyme
  (lambda (end-words input-filepath num-of-lines)
    (let kernel ([sentence-so-far null]
                 [keywords end-words]
                 [paragraph-so-far null]
                 [end-words end-words])
      (let* ([preceding-three-words (tally-preceding-phrases keywords input-filepath)]
             [random-phrase
              (let ([len (length preceding-three-words)]
                    [phrase (lambda (x) (car (list-ref preceding-three-words (random x))))])
                (if (< len 10)
                    (phrase len)
                    (phrase 10)))])
        (cond [(= num-of-lines (length paragraph-so-far))
               (append (reduce append paragraph-so-far))]
              [(= 3 (length sentence-so-far))
               (let ([new-keywords
                      (let* ([rhyme-second-word
                              (search-rhyme-word (cadr end-words) input-filepath)]
                             [preceding-words (tally-preceding-words rhyme-second-word input-filepath)])
                        (list (car (list-ref preceding-words (random (length preceding-words))))
                              rhyme-second-word))])
                 (kernel null
                         new-keywords
                         (cons (append (cons #\newline (reduce append sentence-so-far)) end-words) paragraph-so-far)
                         new-keywords))]
              [else (kernel (cons random-phrase sentence-so-far)
                            (take random-phrase 2)
                            paragraph-so-far
                            end-words)])))))

;;; Procedure:
;;;   generate-paragraph
;;; Parameters:
;;;   end-words, a list of two strings
;;;   input-filepath, a string which tells the location of the txt file containing extracted lyrics
;;;   num-of-lines, a positive integer
;;; Purpose:
;;;   to create a paragraph of a string of words
;;; Produces:
;;;   result, a list of strings
(define generate-paragraph
  (lambda (end-words input-filepath num-of-lines)
    (let kernel ([sentence-so-far null]
                 [keywords end-words]
                 [paragraph-so-far null]
                 [end-words end-words])
      (let* ([preceding-three-words (tally-preceding-phrases keywords input-filepath)]
             [random-phrase
              (let ([len (length preceding-three-words)]
                    [phrase (lambda (x) (car (list-ref preceding-three-words (random x))))])
              (if (< len 10)
                  (phrase len)
                  (phrase 10)))])
        (cond [(= num-of-lines (length paragraph-so-far))
               (reduce append paragraph-so-far)]
              [(= 3 (length sentence-so-far))
               (let ([new-keywords
                      (let* ([preceding-phrases
                              (tally-preceding-phrases (take (car sentence-so-far) 2) input-filepath)])
                        (take (car (list-ref preceding-phrases (random (length preceding-phrases)))) 2))])
                 (kernel null
                         new-keywords
                         (cons (append (cons #\newline (reduce append sentence-so-far)) end-words) paragraph-so-far)
                         new-keywords))]
              [else (kernel (cons random-phrase sentence-so-far)
                            (take random-phrase 2)
                            paragraph-so-far
                            end-words)])))))

;;; Procedure:
;;;   search-rhyme-word
;;; Parameters:
;;;   word, a string
;;;   filepath, a string which tells the location of the txt file containing extracted lyrics
;;; Purpose:
;;;   to generate a word that matches the last three letters of the inputted word
;;; Produces:
;;;   result, a string   
(define search-rhyme-word
  (lambda (word filepath)
    (let ([input-port (open-input-file filepath)])
      (let kernel ([rhyming-words null])
        (let ([read-word (read input-port)])
          (cond [(eof-object? read-word)
                 (let ([tallied-rhyming-words (tally-all rhyming-words)])
                   (symbol->string (car (list-ref tallied-rhyming-words (random (length tallied-rhyming-words))))))]   
                [(and (rhyme? (convert-to-string read-word) word)
                      (not (equal? (convert-to-string read-word) word)))
                 (kernel (cons read-word rhyming-words))]
                [else (kernel rhyming-words)]))))))

;;; Procedure:
;;;   write-each-string
;;; Parameters:
;;;   vec, a vector containing multiple strings
;;;   filepath, a string which tells the location of the txt file
;;;   onto which the procedure extracts all the strings in vec
;;; Purpose:
;;;   to display all strings in vec into the txt file located in filepath
;;; Produces:
;;;   result, a txt file
(define write-each-string
  (lambda (vec filepath)
    (let ([output-port (open-output-file filepath #:exists 'replace)])
      (let kernel ([pos 0])
        (cond [(>= pos (vector-length vec))
               (close-output-port output-port)]
              [else (display (string-append (vector-ref vec pos) " ") output-port)
                    (kernel (+ pos 1))])))))

;;; Procedure:
;;;   tally-preceding-phrases
;;; Parameters:
;;;   search-keywords, a list of two strings in filepath
;;;   input-filepath, a string which tells the location of the txt file containing extracted lyrics
;;; Purpose:
;;;   To tally the list of all phrases that precede search-keyword
;;;   and sort the tallies by frequency.
;;; Produces:
;;;   result, a list of lists each containing a phrase (as 3 strings) and an integer
(define tally-preceding-phrases
  (lambda (search-keywords input-filepath)
    (let* ([list-of-phrases (preceding-phrases search-keywords input-filepath)]           
           [tallied-list (tally-all list-of-phrases)])
      (sort tallied-list #:key cadr >))))

;;; Procedure:
;;;   preceding-phrases
;;; Parameters:
;;;   search-keywords, a list of two strings in filepath
;;;   filepath, a string which tells the location of the txt file containing extracted lyrics
;;; Purpose:
;;;   To search through filepath and make a list of all phrases that precede search-keyword
;;; Produces:
;;;   lst, a list of lists containing 3 strings
(define preceding-phrases
  (lambda (search-keywords filepath)
    (let ([input-port (open-input-file filepath)]
          [keywords (map string->symbol search-keywords)])             
      (let kernel ([five-words (list null null null null null)]          
                   [save-phrases null]                           
                   [two-next-words (list null null)])
        (let ([current-word (list (read input-port))])
          (cond
            [(eof-object? (car current-word))
             save-phrases]
            [(equal? keywords two-next-words)
             (kernel (append (cdr five-words) current-word)
                     (cons (map convert-to-string (take five-words 3)) save-phrases)
                     (append (cdr two-next-words) current-word))]
            [else
             (kernel (append (cdr five-words) current-word)
                     save-phrases
                     (append (cdr two-next-words) current-word))]))))))

;;; Procedure:
;;;   tally-preceding-words
;;; Parameters:
;;;   search-keyword, a string in filepath
;;;   filepath, a string which tells the location of the txt file containing extracted lyrics
;;; Purpose:
;;;   To tally the list of all words that appear 1 word before search-keyword
;;;   and sort the tallies by frequency.
;;; Produces:
;;;   result, a list of lists each containing a word (as a string) and an integer
(define tally-preceding-words
  (lambda (search-keyword filepath)
    (let* ([preceding-words (preceding-words search-keyword filepath)]           
           [downcase-list (map string-downcase preceding-words)]
           [tallied-list (tally-all downcase-list)])
      (sort tallied-list #:key cadr >))))

;;; Procedure:
;;;   preceding-words
;;; Parameters:
;;;   search-keyword, a string in filepath
;;;   filepath, a string which tells the location of the txt file containing extracted lyrics
;;; Purpose:
;;;   To search through filepath and make a list of all words that appear 1 word before search-keyword
;;; Produces:
;;;   lst, a list of strings
(define preceding-words
  (lambda (search-keyword filepath)
    (let ([input-port (open-input-file filepath)])
      (let kernel ([temporary-save-word null]
                   [save-word null])
        (let ([next-word (read input-port)])
          (cond [(eof-object? next-word)
                 save-word]
                [(string-ci=? (convert-to-string next-word)
                              search-keyword)
                 (kernel next-word (cons (convert-to-string temporary-save-word) save-word))]
                [else (kernel next-word save-word)]))))))

;;; Procedure:
;;;   convert-to-string
;;; Parameters:
;;;   val, a number or symbol
;;; Purpose:
;;;   to convert val (a symbol or a number) into a string
;;; Produces:
;;;   str, a string
(define convert-to-string
  (lambda (val)
    (cond [(symbol? val)
           (symbol->string val)]
          [(number? val)
           (number->string val)])))

