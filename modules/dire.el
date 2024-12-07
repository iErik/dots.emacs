(require 'package)

(use-package dirvish
  :ensure t
  :after (all-the-icons)
  :init
  (dirvish-override-dired-mode)
  :config

  (setq dirvish-attributes
	'(
	  vc-state
	  subtree-state
	  all-the-icons
	  collapse
	  ;git-msg
	  file-size
	  ))

  (setq dirvish-mode-line-height 35)

  (setq dirvish-header-line-format
	'(:left (path) :right (free-space))
	dirvish-mode-line-format
	'(:left (sort file-time " " file-size symlink)
	  :right (omit yank index)))

  (setq delete-by-moving-to-trash t)

  :bind
  (("C-n" . dirvish-side)

   :map dirvish-mode-map
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump)
   ("s"   . dirvish-quicksort)
   ("v"   . dirvish-vc-menu)
   ("TAB" . dirvish-subtree-toggle)
   ("M-e" . dirvish-emerge-menu)

  ))
