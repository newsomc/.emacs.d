(require 'go-autocomplete)
(require 'auto-complete)
(require 'auto-complete-config)

(global-auto-complete-mode t)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-user-dictionary-files "~/.emacs.d/.dict")

(delq 'ac-source-yasnippet ac-sources)

(setq ac-quick-help-delay 0.1)
(setq ac-delay 0)
(setq ac-auto-show-menu 0)
(setq ac-auto-start 3)
(setq ac-ignore-case nil)
(setq ac-menu-height 20)
(setq ac-use-menu-map t)
(setq ac-use-quick-help nil)

(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(require 'semantic)
(semantic-mode 1)

(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))

(add-hook 'ielm-mode-hook 'ielm-auto-complete)

(provide 'setup-auto-complete)
