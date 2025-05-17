(defun c:ltalignspace (/ p1 p2)
  (if (and (setq p1 (getpoint "\nPick first corner (endpoint): "))
           (setq p2 (getpoint "\nPick opposite corner (endpoint): ")))
    (progn
      (vl-cmdf "_.zoom" "_window" p1 p2)
      (vlax-put
        (vla-get-activepviewport
          (vla-get-activedocument (vlax-get-acad-object)))
        'DisplayLocked
        :vlax-true)
    )
  )
  (princ)
)