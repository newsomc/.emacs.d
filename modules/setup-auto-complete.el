(require 'auto-complete)
(require 'auto-complete-config)

(global-auto-complete-mode t)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-user-dictionary-files "~/.emacs.d/.dict")

(delq 'ac-source-yasnippet ac-sources)

(setq ac-auto-show-menu 1.0)
(setq ac-auto-start 3)
(setq ac-ignore-case nil)
(setq ac-menu-height 20)
(setq ac-use-menu-map t)
(setq ac-use-quick-help nil)

(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(require 'semantic)
(semantic-mode 1)

(provide 'setup-auto-complete)
