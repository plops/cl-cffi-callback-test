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
			       (struct Big ()
				(decl ((i0 :type "unsigned long int")
				       (i1 :type "unsigned long int"))))
			       (raw "typedef struct Big Big;")
			       (enum CallbackResult
				     (RESULT_OK 0)
				     (RESULT_FAIL (hex #x80000000)))
			       (raw "typedef enum CallbackResult CallbackResult;")
			       (raw "typedef CallbackResult (*Callback0)(Big big);")
			       (raw "typedef CallbackResult (*Callback1)(Big *big);")
			       #+nil (function (make_big ((a :type "unsigned long int")
						    (b :type "unsigned long int")
						    )
						   Big))
			       (function (allocate_big ((a :type "unsigned long int")
						    (b :type "unsigned long int")
						    )
						   Big*))
			       (function (free_big ((big :type Big*))
						   void))
			       (function (run0 ((cb :type Callback0)
						(big :type Big))
					       void))
			       (function (run1 ((cb :type Callback1)
						(big :type Big*))
					       void)))))
 (with-open-file (s (merge-pathnames "stage/cl-cffi-callback-test/source/wal.c"
				     (user-homedir-pathname))
		    :direction :output
		    :if-does-not-exist :create
		    :if-exists :supersede)
   (emit-cpp :str s :code `(with-compilation-unit
			       (include <wal.h>)
			     (include <stdlib.h>)
			     (with-compilation-unit 
			      (function (make_big ((a :type "unsigned long int")
						   (b :type "unsigned long int")
						   )
						  Big)
					(let ((big :type Big :init (list a b)))
					  (return big)))
			       (function (allocate_big ((a :type "unsigned long int")
						    (b :type "unsigned long int")
						    )
						   Big*)
					 (let ((big :type Big* :init (funcall malloc (funcall sizeof Big))))
					   (setf big->i0 a
						 big->i1 b)
					   (return big)))
			       (function (free_big ((big :type Big*))
						   void)
					 (funcall free big))
			       (function (run0 ((cb :type Callback0)
						(big :type Big))
					       void)
					 (funcall cb big))
			       (function (run1 ((cb :type Callback1)
						(big :type Big*))
					       void)
					 (funcall cb big)))))))

(defpackage :f
  (:use :cl :autowrap))



(in-package :f)

(delete-file (merge-pathnames "stage/cl-cffi-callback-test/wal.x86_64-pc-linux-gnu.spec"
			      (user-homedir-pathname)))

(eval-when (:compile-toplevel :execute :load-toplevel)
  (c-include (namestring (merge-pathnames "stage/cl-cffi-callback-test/include/wal.h"
			       (user-homedir-pathname)))
            :spec-path (merge-pathnames "stage/cl-cffi-callback-test/"
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
            :exclude-sources ("/usr/*"
                              )
            :include-definitions ("uint64_t")
	    :include-sources ("/usr/include/stdint.h")
            :sysincludes '("/usr/include"
                           "/home/martin/stage/cl-cffi-callback-test/include")
            :trace-c2ffi t ))




(cffi:load-foreign-library "lib/libwal.so")


(defmacro with-big ((var a b) &body body)
  `(let ((,var (allocate-big ,a ,b)))
     ,@body
     (free-big ,var)))


(with-big (s 1 2)
    (run1 ))



#+nil
(make-big 1 2)
#+nil
(run1 )
