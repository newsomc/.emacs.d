;; misc mode cleanup to maintain clean slate
(add-hook 'lisp-interaction-mode-hook
  (lambda ()
    (local-unset-key (kbd "C-j"))))

;; jade, stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; yaml
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; tab characters
(setq js2-basic-offset 2)

(provide 'mode-mappings)
