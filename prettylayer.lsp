(vl-load-com)

(defun c:prettylayers (/ acDoc oLayers colorList colorIndex oLayer trueColor acAllViewports)

  (setq acDoc (vla-get-ActiveDocument (vlax-get-acad-object)))
  (setq oLayers (vla-get-Layers acDoc))
  (setq acAllViewports 1)

  ;; 63 approximate RGB values from Le Corbusier's Architectural Polychromy
  (setq colorList
        '((254 246 228) (252 237 196) (250 228 140) (247 203 99)
          (242 176 52)  (255 211 147) (255 202 109) (255 175 71)
          (232 132 73)  (226 92 65)   (199 54 54)   (167 45 48)
          (139 31 49)   (94  22 37)   (77 34 37)    (65 24 30)
          (39 24 29)    (233 223 182) (218 204 157) (202 185 127)
          (183 166 109) (153 139 94)  (120 113 80)  (91 87 65)
          (69 66 52)    (46 44 38)    (229 229 217) (200 200 190)
          (177 177 169) (144 143 136) (112 111 106) (77 77 75)
          (48 48 47)    (26 26 25)    (234 237 233) (209 217 211)
          (183 198 193) (155 179 173) (127 161 154) (106 141 136)
          (83 120 114)  (67 102 96)   (45 75 71)    (28 58 55)
          (219 221 211) (195 199 189) (175 179 168) (149 154 143)
          (127 132 121) (105 110 99)  (82 86 77)    (60 64 54)
          (33 36 28)    (207 226 229) (165 199 209) (114 168 183)
          (74 131 155)  (47 93 124)   (39 72 107)   (36 60 85)
          (31 49 72))
  )

  (setq colorIndex 0)

  (vlax-for oLayer oLayers
    ;; Skip layer 0 and Defpoints
    (if (not (member (strcase (vla-get-Name oLayer)) '("0" "DEFPOINTS")))
      (progn
        (setq trueColor (vla-get-TrueColor oLayer))
        (apply 'vla-SetRGB (cons trueColor (nth colorIndex colorList)))
        (vla-put-TrueColor oLayer trueColor)
        (setq colorIndex (1+ colorIndex))
        (if (>= colorIndex (length colorList))
          (setq colorIndex 0)
        )
      )
    )
  )

  (vla-Regen acDoc acAllViewports)
  (princ "\nApplied Le Corbusier's Architectural Polychromy (63 colors) to all layers.")
  (princ)
)
