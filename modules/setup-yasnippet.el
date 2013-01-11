(require 'yasnippet)

;; use only own snippets
(setq yas/snippet-dirs '("~/.emacs.d/snippets"))
(yas/global-mode 1)

(setq yas/indent-line 'fixed)

;; jump to end of snippet definition
(define-key yas/keymap (kbd "<return>") 'yas/exit-all-snippets)

;; don't expand yasnippets in every setting
(setq yas/expand-only-for-last-commands
      '(
        self-insert-command
        yas/exit-all-snippets
        yas/abort-snippet
        yas/skip-and-clear-or-delete-char
        yas/next-field-or-maybe-expand
        ))

;; inter-field navigation
(defun yas/goto-end-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
        (position (yas/field-end (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-end-of-line)
      (goto-char position))))

(defun yas/goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas/snippets-at-point)))
        (position (yas/field-start (yas/snippet-active-field snippet))))
    (if (= (point) position)
        (move-beginning-of-line)
      (goto-char position))))

(define-key yas/keymap (kbd "C-e") 'yas/goto-end-of-active-field)
(define-key yas/keymap (kbd "C-a") 'yas/goto-start-of-active-field)

;; no dropdowns
(setq yas/prompt-functions '(yas/ido-prompt yas/completing-prompt))

;; wrap around region
(setq yas/wrap-around-region t)

(add-hook 'yas-minor-mode-hook '(lambda ()
  (define-key yas-minor-mode-map [(tab)] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c TAB")
    'yas-expand-from-trigger-key)))

(provide 'setup-yasnippet)
