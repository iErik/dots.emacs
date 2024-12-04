(when (file-exists-p custom-file) (load custom-file))

(load "packages")
(load "options")
(load "keys")
(load "editing")
(load "theming")
(load "tabbar")

