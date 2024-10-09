;; Load custom file
(when (file-exists-p custom-file) (load custom-file))

(load "packages")
(load "keys")

(defun reset-all-keybindings ()
  (mapcar
   (lambda (key)
     (global-unset-key (vector key)))
   (number-sequence 0 127)))

(load-theme 'kanagawa t nil)

(when (display-graphic-p)
  (require 'all-the-icons))

(set-face-attribute
  'default nil
  :font "CaskaydiaCove Nerd Font-10")

;(global-tab-line-mode t)
(tab-bar-mode t)

(set-face-attribute 'tab-bar nil
		    :background "FF0000"
		    :foreground "000000"
		    :height 1.0)

;; Keybindings

(defun reload-conf ()
  (interactive)
  (load init-file))

(global-set-key (kbd "C-S-r") 'reload-conf)

; display-buffer-alist
; display-buffer-at-bottom
; display-buffer-below-selected

; next-buffer
; previous-buffer

; kill-buffer
; save-buffer

; switch-to-buffer
; switch-to-prev-buffer
; switch-to-next-buffer

; enlarge-window-horizontally
; enlarge-window
; shrink-window
; shrink-window-horizontally

; balance-windows
; compare-windows

; fit-window-to-buffer
; maximize-window
; minimize-window

; delete-other-windows
; delete-window
; delete-windows-vertically
; delete-windows-on

; quit-window
