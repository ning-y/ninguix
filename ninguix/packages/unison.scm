(define-module (ninguix packages unison)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (guix packages))

; The GNU Guix repository's unison is 2.51.2, which is just shy of the minimum
; require version for backwards OCaml compatibility, 2.52.0. I tried to bump the
; GNU Guix repository's unison to 2.52.0 and above, but I kept encountering
; errors in building the HTML docs. Without building the docs, however, my bump
; to the unison version works just fine.
(define-public unison-docless
  (package
    (name "unison-docless")
    (version "2.53.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/bcpierce00/unison")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0f7bjw3c60awwczxlc90vc8a878ksv474igbqlncblagjqsz9vhz"))
              ))
              ; (patches (search-patches "unison-fix-ocaml-4.08.patch"))))
    (build-system gnu-build-system)
    (outputs '("out"))
    (native-inputs
     `(("ocaml" ,ocaml-4.09)
       ;; For documentation
       ("ghostscript" ,ghostscript)
       ("texlive" ,(texlive-updmap.cfg
                    (list texlive-fonts-ec texlive-dvips-l3backend)))
       ("hevea" ,hevea)
       ("lynx" ,lynx)
       ("which" ,which)))
    (arguments
     `(#:parallel-build? #f
       #:parallel-tests? #f
       #:test-target "selftest"
       #:tests? #f ; Tests require writing to $HOME.
                   ; If some $HOME is provided, they fail with the message
                   ; "Fatal error: Skipping some tests -- remove me!"
       #:phases
         (modify-phases %standard-phases
           (delete 'configure)
           (add-before 'install 'prepare-install
             (lambda* (#:key outputs #:allow-other-keys)
               (let* ((out (assoc-ref outputs "out"))
                      (bin (string-append out "/bin")))
                 (mkdir-p bin)
                 (setenv "HOME" out) ; forces correct INSTALLDIR in Makefile
                 #t)))
           (add-after 'install 'install-fsmonitor
             (lambda* (#:key outputs #:allow-other-keys)
               (let* ((out (assoc-ref outputs "out"))
                      (bin (string-append out "/bin")))
                 ;; 'unison-fsmonitor' is used in "unison -repeat watch" mode.
                 (install-file "src/unison-fsmonitor" bin)
                 #t))))))
    (home-page "https://www.cis.upenn.edu/~bcpierce/unison/")
    (synopsis "File synchronizer")
    (description
     "A more up-to-date version of the GNU Guix repository's Unison, but without docs.")
    (license license:gpl3+)))

unison-docless
