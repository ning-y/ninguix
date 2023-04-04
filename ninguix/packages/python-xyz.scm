(define-module (ninguix packages python-xyz)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (gnu packages moreutils)
  #:use-module (gnu packages ghostscript)
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

(define-public python-nu
  (package
    (name "python-nu")
    (version "0.0.2")
    (source (origin
             (method git-fetch)
             (uri (git-reference
                   (url "https://github.com/ning-y/nu")
                   (commit version)))
             (file-name (git-file-name name version))
             (sha256
              (base32
               "0h4ycz9kvpwfi9wx8f8wp29amvvycwg8ccri32abg02b1z01n1id"))))
    (build-system python-build-system)
    (propagated-inputs (list python-xdg ghostscript moreutils))
    (home-page "https://github.com/ning-y/nu")
    (synopsis "Assorted utilities for ning's personal use.")
    (description "Assorted utilities for ning's personal use.")
    (license #f)))
