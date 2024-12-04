(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package all-the-icons
  :ensure)

;;(use-package centaur-tabs :ensure)

(use-package treemacs
  :ensure t
  :defer t
  :config (treemacs-start-on-boot))

(use-package nov
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package vterm :ensure)

(load "odin-mode")

(use-package evil
  :ensure
  :init

  ;; The default Evil state.  This is the state a buffer
  ;; starts in when it is not otherwise configured (see
  ;; evil-set-initial-state and evil-buffer-regexps). The
  ;; value may be one of ‘normal’, ‘insert’, ‘visual’,
  ;; ‘replace’, ‘operator’, ‘motion’ and ‘emacs’.
  (setq evil-default-state 'normal)

  ;; Regular expressions determining the initial state for
  ;; a buffer. Entries have the form ‘(REGEXP . STATE)’,
  ;; where `REGEXP' is a regular expression matching the
  ;; buffer’s name and `STATE' is one of ‘normal’,
  ;; ‘insert’, ‘visual’, ‘replace’, ‘operator’, ‘motion’,
  ;; ‘emacs’ and ‘nil’.  If `STATE' is ‘nil’, Evil is
  ;; disabled in the buffer.
  (setq evil-buffer-regexps '(("^ \\*load\\*")))

  ;; The key used to change to and from Emacs state. Must
  ;; be readable by ‘read-kbd-macro’.  For example: “C-z”.
  (setq evil-toggle-key (kbd "C-\\"))

  ;; Whether ‘C-i’ jumps forward in the jump list (like
  ;; Vim). Otherwise, ‘C-i’ inserts a tab character.
  (setq evil-want-C-i-jump t)

  ;; Whether ‘C-u’ deletes back to indentation in insert
  ;; state. Otherwise, ‘C-u’ applies a prefix argument. The
  ;; binding of ‘C-u’ mirrors Emacs behaviour by default
  ;; due to the relative ubiquity of prefix arguments.
  (setq evil-want-C-u-delete nil)

  ;; Whether ‘C-u’ scrolls up (like Vim).  Otherwise, ‘C-u’
  ;; applies a prefix argument. The binding of ‘C-u’
  ;; mirrors Emacs behaviour by default due to the relative
  ;; ubiquity of prefix arguments.
  (setq evil-want-C-u-scroll t)

  ;; Whether ‘C-d’ scrolls down (like Vim).
  (setq evil-want-C-d-scroll t)

  ;; Whether ‘C-w’ deletes a word in Insert state.
  (setq evil-want-C-w-delete t)

  ;; Whether ‘C-w’ prefixes windows commands in Emacs state.
  (setq evil-want-C-w-in-emacs-state nil)

  ;; Whether ‘Y’ yanks to the end of the line. The default
  ;; behavior is to yank the whole line, like Vim.
  (setq evil-want-Y-yank-to-eol nil)

  ;; Whether insert state bindings should be used. Bindings
  ;; for escape, delete and evil-toggle-key. are always
  ;; available. If this is non-nil, default Emacs bindings
  ;; are by and large accessible in insert state.
  (setq evil-disable-insert-state-bindings nil)

  ; Whether to use regular expressions for searching in
  ; ‘/’ and ‘?’.
  (setq evil-regexp-search t)

  ;; The search module to be used.  May be either ‘isearch’,
  ;; for Emacs’ isearch module, or ‘evil-search’, for Evil’s
  ;; own interactive search module.  N.b.  changing this
  ;; will not affect keybindings. To swap out relevant
  ;; keybindings, see ‘evil-select-search-module’ function.
  (setq evil-search-module "isearch")

  ; Whether to indent when opening lines with ‘o’ and ‘O’.
  (setq evil-auto-indent t)

  ;; The number of columns by which a line is shifted. This
  ;; applies to the shifting operators ‘>’ and ‘<’.
  (setq evil-shift-width 2)

  ;; Whether shifting rounds to the nearest multiple. If
  ;; non-nil, ‘>’ and ‘<’ adjust line indentation to the
  ;; nearest multiple of 'evil-shift-width'.
  (setq evil-shift-round t)

  ;; If non-nil, the ‘=’ operator converts between leading
  ;; tabs and spaces.  Whether tabs are converted to spaces
  ;; or vice versa depends on the value of
  ;; ‘indent-tabs-mode’.
  (setq evil-indent-convert-tabs t)

  ;; Whether repeating commands with ‘.’ may move the
  ;; cursor. If nil, the original cursor position is
  ;; preserved, even if the command normally would have
  ;; moved the cursor.
  (setq evil-repeat-move-cursor t)

  ;; Whether the cursor is moved backwards when exiting
  ;; insert state. If non-nil, the cursor moves “backwards”
  ;; when exiting insert state, so that it ends up on the
  ;; character to the left. Otherwise it  remains in place,
  ;; on the character to the right.
  (setq evil-move-cursor-back t)

  ;; Whether the cursor can move past the end of the line.
  ;; If non-nil, the cursor is allowed to move one character
  ;; past the end of the line, as in Emacs.
  (setq evil-move-beyond-eol nil)

  ;; Whether horizontal motions may move to other lines. If
  ;; non-nil, certain motions that conventionally operate in
  ;; a single line may move the cursor to other lines.
  ;; Otherwise, they are restricted to the current line.
  ;; This applies to ‘h’, ‘SPC’, ‘f’, ‘F’, ‘t’, ‘T’, ‘~’.
  (setq evil-cross-lines nil)


  ;; Whether movement commands respect ‘visual-line-mode’.
  ;; If non-nil, ‘visual-line-mode’ is generally respected
  ;; when it is on.  In this case, motions such as ‘j’ and
  ;; ‘k’ navigate by visual lines (on the screen) rather
  ;; than “physical” lines (defined by newline characters).
  ;; If nil, the setting of ‘visual-line-mode’ is ignored.

  (setq evil-respect-visual-line-mode nil)


  ;; Whether ‘$’ “sticks” the cursor to the end of the line.
  ;; If non-nil, vertical motions after ‘$’ maintain the
  ;; cursor at the end of the line, even if the target line
  ;; is longer.  This is analogous to ‘track-eol’, but
  ;; respects Evil’s interpretation of end-of-line.
  (setq evil-track-eol t)

  ;; Analogue of vim’s ‘startofline’. If nil, preserve
  ;; column when making relevant movements of the cursor.
  ;; Otherwise, move the cursor to the start of the line.
  (setq evil-start-of-line nil)

  ;; The default cursor.  May be a cursor type as per
  ;; ‘cursor-type’, a color string as passed to
  ;; ‘set-cursor-color’, a zero-argument function for
  ;; changing the cursor, or a list of the above.
  (setq evil-default-cursor t)

  ;; If non-nil window creation and deletion trigger
  ;; rebalancing.
  (setq evil-auto-balance-windows t)

  ;; If non-nil split windows are created below.
  (setq evil-split-window-below t)

  ;; If non-nil vertically split windows with are created
  ;; to the right.
  (setq evil-vsplit-window-right t)
  :config
  (evil-mode 1))


;; Themes
;; ------

(defun use-theme (theme-name)
  `(use-package ,theme-name :ensure :defer))

(use-theme 'soothe-theme)
(use-theme 'flexoki-themes)
(use-theme 'doom-themes)
(use-theme 'kanagawa-theme)
(use-theme 'ef-themes)
(use-theme 'nano-theme)
(use-theme 'grandshell-theme)
(use-theme 'ample-theme)
(use-theme 'modus-themes)
(use-theme 'kaolin-themes)

