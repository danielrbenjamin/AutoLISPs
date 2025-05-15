(defun c:chlayer ()
  (setq layer-substr (getstring "\nEnter layer substring: "))
  (setq layers (vla-get-layers (vla-get-activedocument (vlax-get-acad-object))))
  (setq matching-layers '())

  ;; Collect matching layers
  (vlax-for layer layers
    (if (wcmatch (strcase (vla-get-name layer)) (strcat "*" (strcase layer-substr) "*"))
      (setq matching-layers (cons (vla-get-name layer) matching-layers))
    )
  )
  (setq matching-layers (reverse matching-layers)) ;; Maintain order

  ;; Handle no matches
  (cond
    ((= (length matching-layers) 0)
     (princ "\nNo matching layer found.")
    )
    (t
     ;; Choose layer if more than one
     (setq layer-confirmed nil)
     (setq current-index 0)
     (setq total-count (length matching-layers))
     (while (not layer-confirmed)
       (setq layer (nth current-index matching-layers))
       (setq response (getstring (strcat "\nFound layer (" (itoa (1+ current-index)) "/" (itoa total-count) "): " layer ". Press Enter to use, or 'n' for next: ")))
       (cond
         ((= response "")  ; Enter key pressed
          (setq layer-confirmed t)
         )
         ((= (strcase response) "N")
          (setq current-index (rem (1+ current-index) total-count))
         )
       )
     )

     ;; Prompt for object selection
     (prompt "\nSelect objects to move to layer (or use current selection)...")
     (setq ss (ssget '((0 . "*")))) ; Select all object types
     (if ss
       (progn
         (setq i 0)
         (while (< i (sslength ss))
           (setq obj (vlax-ename->vla-object (ssname ss i)))
           (vla-put-layer obj layer)
           (setq i (1+ i))
         )
         (princ (strcat "\nMoved " (itoa (sslength ss)) " object(s) to layer: " layer))
       )
       (princ "\nNo objects selected.")
     )
    )
  )
  (princ)
)