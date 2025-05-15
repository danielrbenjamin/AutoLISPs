(defun c:opendir ()
  (startapp
    (strcat "explorer.exe /select," (getvar "DWGPREFIX") (getvar "DWGNAME"))
  )
  (princ)
)

