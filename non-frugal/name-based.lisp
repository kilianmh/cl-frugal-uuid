;;;; non-frugal/name-based.lisp

(in-package #:frugal-uuid)

(declaim (ftype (function (uuid string) (values uuid &optional)) make-v3))
(defun make-v3 (namespace name)
  (let ((digest (ironclad:make-digest :md5)))
    (ironclad:update-digest digest (fuuid:to-octets namespace))
    (ironclad:update-digest digest 
                            (babel:string-to-octets name :encoding :utf-8))
    (fuuid:make-v3-from-octets (ironclad:produce-digest digest))))

(declaim (ftype (function (uuid string) (values uuid &optional)) make-v5))
(defun make-v5 (namespace name)
    (let ((digest (ironclad:make-digest :sha1)))
      (ironclad:update-digest digest (fuuid:to-octets namespace))
      (ironclad:update-digest digest 
                              (babel:string-to-octets name :encoding :utf-8))
      (fuuid:make-v5-from-octets (ironclad:produce-digest digest))))
