;; ----------------------------------------------------- ;;
;; -> General                                            ;;
;; ----------------------------------------------------- ;;

(unbind-key "C-h")
(unbind-key "C-\\")

(bind-key "C-/" help-map)

(bind-key "C-S-r" (lambda () (interactive)
		  (load init-file)))

; describe-mode
; describe-function
; describe-variable
; describe-key

;; ----------------------------------------------------- ;;
;; -> Window Management                                  ;;
;; ----------------------------------------------------- ;;

(bind-key "M-\\" 'split-window-right)
(bind-key "M--" 'split-window-below)
(bind-key "M-="  'balance-windows)

(bind-key "M-h" 'windmove-left)
(bind-key "M-j" 'windmove-down)
(bind-key "M-k" 'windmove-up)
(bind-key "M-l" 'windmove-right)

(bind-key "M-w" 'delete-window)
(bind-key "M-q" (lambda () (interactive)
		  (quit-window t)))

(bind-key "C-j" (lambda () (interactive)
	       (enlarge-window +5)))
(bind-key "C-k" (lambda () (interactive)
	       (enlarge-window -5)))

(bind-key "C-l" (lambda () (interactive)
	       (enlarge-window +1 t)))
(bind-key "C-h" (lambda () (interactive)
	       (enlarge-window -1 t)))

;; ----------------------------------------------------- ;;
;; -> Buffer Management                                  ;;
;; ----------------------------------------------------- ;;

(bind-key "M-[" 'previous-buffer)
(bind-key "M-]" 'next-buffer)

; ibuffer

(bind-key "M-p" 'project-list-buffers)

(require 'project)

(defun project-next-buffer ()
  "Switch to the next buffer within the same project."
  (interactive)

  (let* ((current-project (project-current t))
         (project-buffers-l
          (project-buffers current-project))
         (current-buffer (current-buffer))
         (next-buffer (or
          (car (last (member current-buffer project-buffers-l)))
          (car project-buffers-l))))

    (print next-buffer)

    (if next-buffer
        (switch-to-buffer next-buffer)

      (message "No other buffers in the current project."))
  ))

(bind-key "M-<tab>" 'project-next-buffer)

; ------------------------------------------------------- ;
; -> Tab Management                                       ;
; ------------------------------------------------------- ;

(unbind-key "C-n")
(bind-key "C-t" 'tab-new)
(bind-key "C-q" 'tab-close)

(bind-key "C-<tab>" 'tab-next)
(bind-key "C-,"     'tab-previous)
(bind-key "C-."     'tab-next)

; tab-rename

; ------------------------------------------------------- ;
; -> Dired                                                ;
; ------------------------------------------------------- ;

(bind-key "M-d" 'dired)
(bind-key "M-o" 'project-dired)


; ------------------------------------------------------- ;
; -> Evil Bindings                                        ;
; ------------------------------------------------------- ;


; 'normal
; 'insert
; 'visual
; 'replace
; 'operator
; 'motion
; 'emacs

; comment region
; <M-;>


; Buffer-menu-mode-hook

(defun evil-unbind (key)
  (evil-define-key '(normal insert visual) 'global key nil))

(defun evil-bind (modes map key fn)
  (evil-define-key modes map key fn))

(evil-bind 'normal 'global (kbd "\;") 'comment-region)

(evil-unbind (kbd "C-n"))
(evil-unbind (kbd "C-t"))
(evil-unbind (kbd "C-."))

;(add-hook 'Buffer-menu-mode-hook
;	  (lambda ()
;	    ()))

; ------------------------------------------------------- ;
; -> Info Mode                                            ;
; ------------------------------------------------------- ;

(defun info-bindings-h ()
  (interactive)
  (evil-define-key '(normal insert motion) 'local
    (kbd "<return>") 'Info-follow-nearest-node

    (kbd "p") 'Info-prev
    (kbd "n") 'Info-next

    (kbd "[") 'Info-backward-node
    (kbd "]") 'Info-forward-node

    (kbd "q") 'quit-window
    (kbd "u") 'Info-up
    (kbd "m") 'Info-menu
    (kbd "d") 'Info-directory
    (kbd "t") 'Info-top-node
    (kbd "T") 'Info-toc
    (kbd ",") 'Info-history-back
    (kbd ".") 'Info-history-forward))

(add-hook 'Info-mode-hook 'info-bindings-h)
   
; ------------------------------------------------------- ;
; -> VTerm Mode                                           ;
; ------------------------------------------------------- ;

(defun vterm-bindings-h ()
  (interactive)

  (define-key
    vterm-mode-map
    (kbd "C-q") #'vterm-send-next-key)

  (define-key vterm-mode-map
    (kbd "M-]") nil)

  (define-key vterm-mode-map
    (kbd "M-[") nil)

  (define-key vterm-mode-map
    (kbd "M-\\") nil)
  (define-key vterm-mode-map
    (kbd "M--") nil)
  (define-key vterm-mode-map
    (kbd "M-=") nil)

  (define-key vterm-mode-map
    (kbd "M-h") nil)
  (define-key vterm-mode-map
    (kbd "M-j") nil)
  (define-key vterm-mode-map
    (kbd "M-k") nil)
  (define-key vterm-mode-map
    (kbd "M-l") nil)
  (define-key vterm-mode-map
    (kbd "M-q") nil)
  (define-key vterm-mode-map
    (kbd "M-w") nil)

  (define-key vterm-mode-map
    (kbd "C-j") nil)
  (define-key vterm-mode-map
    (kbd "C-k") nil)
  (define-key vterm-mode-map
    (kbd "C-l") nil)
  (define-key vterm-mode-map
    (kbd "C-h") nil))

(add-hook 'vterm-mode-hook 'vterm-bindings-h)
