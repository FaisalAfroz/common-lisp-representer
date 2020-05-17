(in-package #:representer)

(defstruct (representation
             (:conc-name repr-)
             (:constructor make-repr (form mapping)))
  (form (list))
  (mapping (list)))

(defun accumulate-representation (original new)
  "Merges the NEW representation into ORIGINAL one."
  (make-representation
   :form (append (repr-form original) (list (repr-form new)))
   :mapping (prune-alist (append (repr-mapping new)
                                 (repr-mapping original)))))

(defun prune-alist (alist)
  "Remove duplicate keys found in ALIST"
  (reduce #'(lambda (new key-value)
              (if (assoc (car key-value) new) new
                  (append new (list key-value))))
          alist
          :initial-value (list)))