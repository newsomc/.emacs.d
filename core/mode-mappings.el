;; misc mode cleanup to maintain clean slate
(add-hook 'dired-mode-hook
  (lambda ()
    (local-set-key (kbd "<return>") 'dired-find-file)))

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (local-set-key (kbd "<return>") 'ibuffer-visit-buffer)
    (local-set-key (kbd "<tab>") 'ibuffer-forward-filter-group)))

(add-hook 'lisp-interaction-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)
    (local-unset-key (kbd "C-j"))))

(add-hook 'lisp-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)))

;; jade, stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; yaml
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'mode-mappings)
