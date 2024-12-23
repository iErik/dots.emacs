(load "kanagawa/kanagawa-theme")

(set-face-attribute
 'default nil
 :weight 'normal
 :font "CaskaydiaCove Nerd Font-10")

(load-theme 'kanagawa t nil)

(set-frame-parameter nil 'alpha-background 95)
(add-to-list 'default-frame-alist '(alpha-background . 95))

(set-face-attribute
 'Info-quoted nil
 :font "Ubuntu Mono Nerd Font-11")
