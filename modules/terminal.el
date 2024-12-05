(defun disable-lines-n-columns ()
  (interactive)
  (display-line-numbers-mode 0)
  (display-fill-column-indicator-mode 0))


;-------------------------------------------------------- ;
; -> EShell/Term                                          ;
; ------------------------------------------------------- ;

;; comint-scroll-to-bottom-on-input
;; comint-move-point-for-output

(setq comint-terminfo-terminal "xterm-256color")
(setq eshell-prefer-lisp-functions t)

(add-hook 'term-mode-hook 'disable-lines-n-columns)
(add-hook 'eshell-mode-hook 'disable-lines-n-columns)

; ------------------------------------------------------- ;
; -> VTerm                                                ;
; ------------------------------------------------------- ;

(add-hook 'vterm-mode-hook 'disable-lines-n-columns)
;(setq vterm-term-environment-variable "eterm-color")
(setq vterm-always-compile-module t)
