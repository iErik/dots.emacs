(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'all-the-icons)
  (package-install 'all-the-icons))
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'kanagawa-theme)
  (package-install 'kanagawa-theme))

(require 'evil)
(evil-mode 1)

(use-package centaur-tabs
  :ensure
  :demand
  :config
  (centaur-tabs-mode t))
