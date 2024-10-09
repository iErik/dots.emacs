(global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-j"))
(global-unset-key (kbd "C-k"))
(global-unset-key (kbd "C-l"))
(global-unset-key (kbd "C-q"))
;(global-unset-key (kbd "C-x"))
(global-unset-key (kbd "S-{"))
(global-unset-key (kbd "S-}"))
;(global-unset-key (kbd "C-["))
;(global-unset-key (kbd "C-]"))

(global-set-key (kbd "C-/") help-map)
;(global-set-key (kbd "S-\|") ctl-x-map)

(global-set-key (kbd "C-\\") 'split-window-right)
(global-set-key (kbd "C--")  'split-window-below)
(global-set-key (kbd "C-=")  'balance-windows)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-l") 'windmove-right)

;(global-set-key (kbd "S-{") 'previous-buffer)
;(global-set-key (kbd "S-}") 'next-buffer)

(global-set-key (kbd "M-[") 'previous-buffer)
(global-set-key (kbd "M-]") 'next-buffer)

(global-set-key (kbd "C-q") 'delete-window)
(global-set-key (kbd "C-w") (lambda () (interactive)
                             (quit-window t)))



;; comment-region


; dired
; dired-at-pont
; dired-create-directory
; dired-clean-directory
; dired-prev-dirline
; dired-next-dirline
; dired-do-copy
; dired-do-delete
; dired-do-info
; dired-do-chmod
; dired-do-load
; dired-do-rename
; dired-do-print
; dired-do-touch
; dired-do-shell-command
; dired-up-directory
; dired-flag-file-deletion
; dired-view-file
; dired-display-file
; dired-hide-subdir

; browse-url-of-dired-file
;  Command: In Dired, ask a WWW browser to display the
; file named on this line.

; dired-mode
;  Function: Mode for "editing" directory listings.
;;   Command: Find files in DIR that contain matches for
;;            REGEXP and start Dired on output.

;; find-lisp-find-dired
;;   Command: Find the files within DIR whose names match
;;            REGEXP.
;; find-lisp-find-dired-filter
;;   Command: Change the filter on a ‘find-lisp-find-dired’
;;            buffer to REGEXP.
;; find-lisp-find-dired-subdirectories
;;   Command: Find all subdirectories of DIR.
;; find-lisp-find-dired-subdirs-other-window
;;   Command: Same as ‘find-lisp-find-dired-subdirectories’,
;;            but use another window.
;; find-name-dired
;;   Command: Search DIR recursively for files matching the
;;            globbing PATTERN,
