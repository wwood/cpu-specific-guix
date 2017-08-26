;;; Copyright © 2016-2017 Ben Woodcroft <donttrustben@gmail.com>
;;;
;;; This code is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (cpu-specific-guix)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages gcc)
  #:use-module (srfi srfi-1))

(define-public (gcc-cpu-specific cpu)
  (let ((base gcc))
    (package
     (inherit base)
     (name "gcc-cpu-specific")
     (version (string-append (package-version base) "-cpu-specific-" cpu))
     (arguments
      (substitute-keyword-arguments (package-arguments base)
        ((#:configure-flags configure-flags)
         `(append ,configure-flags
                  (list (string-append
                         "--with-arch=" ,cpu)))))))))

(define-public (cpu-specific-package base-package cpu)
  (package
    (inherit base-package)
    (name (package-name base-package))
    ;; We must set a higher package version so this package is used instead of
    ;; the package in Guix proper.
    (version (string-append (package-version base-package) "-cpu-specific-" cpu))
    (inputs
     `(,@(package-inputs base-package)
       ("gcc" ,((@@ (gnu packages commencement)
                    gcc-toolchain) (gcc-cpu-specific cpu)))))))
