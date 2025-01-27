; -*- mode: lisp -*-

(asdf:defsystem :binascii
  :version "1.0"
  :author "Nathan Froyd <froydnj@gmail.com>"
  :maintainer "Nathan Froyd <froydnj@gmail.com>"
  :description "A library of ASCII encoding schemes for binary data"
  :license "BSD-style (http://opensource.org/licenses/BSD-3-Clause)"
  :components ((:static-file "LICENSE")
               (:file "package")
               (:file "types" :depends-on ("package"))
               (:file "format" :depends-on ("types"))
               (:file "octets" :depends-on ("types" "format"))
               (:file "ascii85" :depends-on ("octets"))
               (:file "base85" :depends-on ("octets"))
               (:file "base64" :depends-on ("octets"))
               (:file "base32" :depends-on ("octets"))
               (:file "base16" :depends-on ("octets")))
  :in-order-to ((test-op (test-op :binascii/tests))))

(defclass test-vector-file (static-file)
  ())

(defmethod source-file-type ((c test-vector-file) (s module)) "testvec")

(asdf:defsystem :binascii/tests
  :depends-on (binascii rt)
  :version "1.0"
  :perform (test-op (op c)
             (or (symbol-call :rtest :do-tests)
                 (error "TEST-OP failed for BINASCII-TESTS")))
  :components ((:module "tests"
                        :components
                        ((:file "tests")
                         (:test-vector-file "ascii85")
                         (:test-vector-file "base85")
                         (:test-vector-file "base64")
                         (:test-vector-file "base32")
                         (:test-vector-file "base32hex")
                         (:test-vector-file "base16")))))
