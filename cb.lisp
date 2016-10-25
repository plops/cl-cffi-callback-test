(eval-when (:compile-toplevel)
  (ql:quickload :cl-cpp-generator)
  (ql:quickload :cl-autowrap))

(in-package :cl-cpp-generator)

(progn
 (with-open-file (s (merge-pathnames "stage/cl-cffi-callback-test/include/wal.h"
				     (user-homedir-pathname))
		    :direction :output
		    :if-does-not-exist :create
		    :if-exists :supersede)
   (emit-cpp :str s :code `(with-compilation-unit
			       (include <stddef.h>)
			       (struct Big ()
				(decl ((i0 :type uint64_t)
				       (i1 :type uint64_t))))
			       (raw "typedef void(*Cb)"))))
 (with-open-file (s (merge-pathnames "stage/cl-cffi-callback-test/source/wal.c"
				     (user-homedir-pathname))
		    :direction :output
		    :if-does-not-exist :create
		    :if-exists :supersede)
   (emit-cpp :str s :code `(with-compilation-unit
			       (include "wal.h")
			     (decl ((big :type "Big" :init (list 1 2))))
			     (function (run0 ((cb :type "void(*)(Big)"))
					     void)
				       (funcall cb big))))))

(defpackage :f
  (:use :cl :autowrap))

(in-package :f)
(eval-when (:compile-toplevel)
 (c-include "ezono_ngs_api.h"
            :spec-path (merge-pathnames "stage/cl-ngs-linux/"
                                        (user-homedir-pathname))
            :exclude-arch ("arm-pc-linux-gnu"
                           "i386-unknown-freebsd"
                           "i386-unknown-openbsd"
                           "i686-apple-darwin9"
                           "i686-pc-linux-gnu"
                           "i686-pc-windows-msvc"
                           "x86_64-apple-darwin9"
                                        ;"x86_64-pc-linux-gnu"
                           "x86_64-pc-windows-msvc"
                           "x86_64-unknown-freebsd"
                           "x86_64-unknown-openbsd")
            :exclude-sources ("/usr/include/stdio.h"
                              "/usr/include/stdlib.h"
                              "/usr/include/string.h"
                              "/usr/include/ctype.h"
                              "/usr/include/zlib.h"
                              "/usr/include/inttypes.h"
                              "/usr/include/unistd.h"
                              "/usr/include/time.h"
                              "/usr/*"
                              )
            :include-definitions ("size_t"
                                  "uint8_t"
                                  "uint16_t"
                                  "uint32_t")

            :sysincludes '("/usr/include"
                           "/home/martin/stage/cl-cffi-callback-test/include"
                           "/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/include")
            :trace-c2ffi t ))




