; ------------------------------------------------------- ;
; -> Major Modes                                          ;
; ------------------------------------------------------- ;

(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-ts-mode))

;------------------------------------------------------- ;
; -> General Options                                      ;
; ------------------------------------------------------- ;

(defun disable-lines-n-columns ()
  (interactive)
  (display-line-numbers-mode 0)
  (display-fill-column-indicator-mode 0))

(add-to-list 'display-buffer-alist
	     '("*Help*" display-buffer-same-window))
(add-to-list 'display-buffer-alist
	     '("*Apropos" display-buffer-same-window))

(setq use-dialog-box nil)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(add-hook 'dired-mode-hook 'disable-lines-n-columns)
(add-hook 'Buffer-menu-mode-hook 'disable-lines-n-columns)

; visual-line-mode
; subword-mode
; glasses-mode
; balanced-expressions / s-expressions

(global-subword-mode t)
(global-visual-line-mode t)

(setq inhibit-compacting-font-caches t)

;; -> Backup files and Auto-Save files
;; -----------------------------------

(setq backup-directory-alist
      `(("." . ,(expand-file-name
		 "tmp/backup-files/"
		 user-emacs-directory))))

;(make-directory (expand-file-name
;		 "tmp/auto-save-files/"
;		 user-emacs-directory))

(setq auto-save-list-file-prefix
      (expand-file-name
       "tmp/auto-save-files/sessions/"
       user-emacs-directory)
      auto-save-file-name-transforms
       `((".*" ,(expand-file-name
		 "tmp/auto-save-files/"
		 user-emacs-directory) t)))

;(setq create-lockfiles nil)
