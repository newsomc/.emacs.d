(show-smartparens-global-mode t)

(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)
(setq sp-navigate-consider-symbols t)

(sp-add-pair "(*" "*)")

(defun malko/toggle-smartparens-mode ()
  (interactive)
  (call-interactively 'smartparens-mode))

(provide 'setup-smart-parens)
