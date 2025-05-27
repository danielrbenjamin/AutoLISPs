(defun C:doubleoffset (/ esel obj scale offsetDist)
  (vl-load-com)
  (if
    (and
      (setq esel (entsel "\nSelect object to offset to both sides based on scale: "))
      (setq obj (vlax-ename->vla-object (car esel)))
      (wcmatch (vla-get-objectname obj) "*Line,*Polyline,Arc,Circle,Ellipse,Spline,Xline")
    )
    (progn
      ;; Prompt for scale denominator (e.g., enter 50 for 1:50)
      (initget 7)
      (setq scale (getint "\nEnter scale denominator (e.g., 50 for 1:50): "))
      (setq offsetDist (float scale))  ;; Ensure it's a real number

      ;; Offset to positive side
      (vla-offset obj offsetDist)
      ;; Offset to negative side
      (vla-offset obj (- offsetDist))
    )
  )
  (princ)
)