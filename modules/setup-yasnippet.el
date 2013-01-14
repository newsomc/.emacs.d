(require 'yasnippet)

;; use only own snippets
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(setq yas-indent-line 'auto)

;; jump to end of snippet definition
(define-key yas-keymap (kbd "<return>") 'yas-exit-all-snippets)
(define-key yas-keymap (kbd "C-n") 'yas-next-field)
(define-key yas-keymap (kbd "C-p") 'yas-prev-field)

;; don't expand yasnippets in every setting
(setq yas-expand-only-for-last-commands
      '(
        self-insert-command
        yas-exit-all-snippets
        yas-abort-snippet
        yas-skip-and-clear-or-delete-char
        yas-next-field-or-maybe-expand
        ))

;; no dropdowns
(setq yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))

;; wrap around region
(setq yas-wrap-around-region t)

(add-hook 'yas-minor-mode-hook '(lambda ()
  (define-key yas-minor-mode-map [(tab)] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)))

(provide 'setup-yasnippet)
