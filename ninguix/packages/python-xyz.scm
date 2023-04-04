(define-module (ninguix packages python-xyz)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix packages))

(define-public python-xdg
  (package
    (name "python-xdg")
    (version "6.0.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "xdg" version))
              (sha256
               (base32
                "14hwk9j5zjc8rvirw95mrb07zdnpjaxjx2mj3rnq8pnlyaa809r4"))))
    (build-system python-build-system)
    (home-page "https://github.com/srstevenson/xdg-base-dirs")
    (synopsis "Variables defined by the XDG Base Directory Specification")
    (description "Variables defined by the XDG Base Directory Specification")
    (license #f)))
