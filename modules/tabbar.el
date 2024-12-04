(set-face-attribute
 'tab-bar nil
 :font "CaskaydiaCove Nerd Font-10"
 :background (face-background 'default)
 :foreground (face-foreground 'default)
 :box `(:line-width 4 :color ,(face-background 'default) :style nil))

(set-face-attribute
 'tab-bar-tab nil
 :background (face-background 'highlight)
 :weight 'ultra-heavy
 :box nil)

(set-face-attribute
 'tab-bar-tab-inactive nil
 :background (face-background 'default)
 :weight 'normal
 :box nil)

(setq tab-bar-show 1)
(tab-bar-mode 1)

(setq
 tab-bar-close-button nil
 tab-bar-new-button nil)

; tab-bar-tab-group-current
; tab-bar-tab-group-inactive
; tab-bar-tab-inactive
; tab-bar-tab-ungrouped
