;; lisp-mode
(add-hook 'lisp-interaction-mode-hook
  (lambda ()
    (local-unset-key (kbd "C-j"))))

;; tab characters
(setq js2-basic-offset 2)
(setq-default js2-basic-offset 2)

;; jade, stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; yaml
(require 'yaml-mode)
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'mode-mappings)
