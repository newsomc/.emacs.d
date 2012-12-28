;; bm
(define-key bm-show-mode-map
  (kbd "<return>") 'bm-show-goto-bookmark)

;; browse-kill-ring
(define-key browse-kill-ring-mode-map
  (kbd "<return>") 'browse-kill-ring-insert-and-quit)

;; dired-mode
(add-hook 'dired-mode-hook
  (lambda ()
    (local-set-key (kbd "<return>") 'dired-find-file)))

;; ibuffer-mode
(add-hook 'ibuffer-mode-hook
  (lambda ()
    (local-set-key (kbd "<return>") 'ibuffer-visit-buffer)
    (local-set-key (kbd "<tab>") 'ibuffer-forward-filter-group)))

;; lisp-mode
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)))

(add-hook 'lisp-interaction-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)
    (local-unset-key (kbd "C-j"))))

(add-hook 'lisp-mode-hook
  (lambda ()
    (local-set-key (kbd "<tab>") 'indent-for-tab-command)))

;; minibuffer
(define-key minibuffer-local-map
  (kbd "<return>") 'exit-minibuffer)
(define-key minibuffer-local-map
  (kbd "<tab>") 'noop)

(define-key minibuffer-local-completion-map
  (kbd "<return>") 'minibuffer-complete-and-exit)
(define-key minibuffer-local-completion-map
  (kbd "<tab>") 'minibuffer-complete)

;; tab characters
(setq js2-basic-offset 2)
(setq-default js2-basic-offset 2)

;; jade, stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; yaml
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'mode-mappings)
