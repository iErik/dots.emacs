(defun reload-conf () (interactive)
       (load init-file))

(defun reset-all-keybindings ()
  (mapcar
   (lambda (key) (global-unset-key (vector key)))
   number-sequence 0 127))
