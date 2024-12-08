(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


(load "odin-mode")
(use-package rust-mode
  :ensure t
  :init
  (setq rust-mode-treesitter-derive t))

(use-package nix-ts-mode
  :ensure t)

(use-package all-the-icons
  :ensure t)

;;(use-package centaur-tabs :ensure)

(use-package nov
  :ensure t
  :config
    (add-to-list
    'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package vterm :ensure)

;(use-package helm
;  :ensure t
;  :init (helm-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
    ;; How tall the mode-line should be. It's only
    ;; respected in GUI. If the actual char height is
    ;; larger, it respects the actual height.
    (setq doom-modeline-height 35)

    ;; How wide the mode-line bar should be. It's only
    ;; respected in GUI.
    (setq doom-modeline-bar-width 4)

    ;; Whether to use hud instead of default bar. It's
    ;; only respected in GUI.
    (setq doom-modeline-hud t)

    ;; How to detect the project root.
    ;; nil means to use `default-directory'.
    ;; The project management packages have some issues on
    ;; detecting project root. e.g. `projectile' doesn't
    ;; handle symlink folders well, while `project' is
    ;; unable to hanle sub-projects.
    ;; You can specify one if you encounter the issue.
    (setq doom-modeline-project-detection 'auto)

    ;; Whether display icons in the mode-line.
    ;; While using the server mode in GUI, should set the
    ;; value explicitly.
    (setq doom-modeline-icon t)

    (setq doom-modeline-major-mode-color-icon t)
    (setq doom-modeline-buffer-state-icon t)
    (setq doom-modeline-buffer-modification-icon t)
    (setq doom-modeline-highlight-modified-buffer-name t)
    (setq doom-modeline-modal-icon t)

    ;; Whether display the total line number。
    (setq doom-modeline-total-line-number nil))

(use-package dashboard
  :ensure t
  :init (dashboard-setup-startup-hook)
  :config

  ;; Show Dashboard in frames created with `emacsclient -c`
  (setq initial-buffer-choice (lambda ()
    (get-buffer-create dashboard-buffer-name)))

  ;; Value can be:
  ;;  - 'official which displays the official emacs logo.
  ;;  - 'logo which displays an alternative emacs logo.
  ;;  - an integer which displays one of the text banners
  ;;    (see dashboard-banners-directory files).
  ;;  - a string that specifies a path for a custom banner
  ;;    currently supported types are gif/image/text/xbm.
  ;;  - a cons of 2 strings which specifies the path of an
  ;;    image to use and other path of a text file to use
  ;;    if image isn't supported.
  ;;    ("path/to/image/file/image.png" .
  ;;    "path/to/text/file/text.txt").
  ;;  - a list that can display an random banner,
  ;;    supported values are: string (filepath), 'official,
  ;;    'logo and integers.
  (setq dashboard-startup-banner 3)

  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)

  ;; Vertically center content
  (setq dashboard-vertically-center-content t)

  ;; Disable shortcut "jump" indicators for each section
  (setq dashboard-show-shortcuts nil)

  ;; Which items to display on the Dashboard
  ;;(setq dashboard-items '((bookmarks . 5)
   ;;                       (projects .5)))
  )


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
(use-theme 'haki-theme)
(use-theme 'miasma-theme)
(use-theme 'flexoki-themes)
(use-theme 'doom-themes)
(use-theme 'kanagawa-theme)
(use-theme 'ef-themes)
(use-theme 'nano-theme)
(use-theme 'grandshell-theme)
(use-theme 'ample-theme)
(use-theme 'modus-themes)
(use-theme 'kaolin-themes)

