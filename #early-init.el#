(setq gc-const-threshold most-positive-fixnum)

(set-language-environment "UTF-8")
(setq default-input-method nil)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(global-display-line-numbers-mode t)
(global-display-fill-column-indicator-mode t)
(column-number-mode t)

(setq-default display-fill-column-indicator-character ?\s)
(setq-default fill-column 60)

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message "Erik"
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

(advice-add #'display-startup-echo-area-message
            :override #'ignore)
(advice-add #'display-startup-screen
            :override #'ignore)

(setq-default inhibit-redisplay t
	      inhibit-message t)

(add-to-list 'load-path "~/.config/emacs/modules")

;; Set custom file
(setq custom-file
      (expand-file-name
        "emacs-custom.el"
        user-emacs-directory))

(setq init-file
      (expand-file-name "init.el" user-emacs-directory))

(defun reset-inhibited-vars-h ()
  (setq-default inhibit-redisplay nil
		inhibit-message nil)
  (redraw-frame))
(add-hook 'after-init-hook #'reset-inhibited-vars-h)

