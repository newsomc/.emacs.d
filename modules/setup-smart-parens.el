; (smartparens-global-mode t)
(show-smartparens-global-mode t)

(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)
(setq sp-navigate-consider-symbols t)

(sp-add-pair "(*" "*)")

(provide 'setup-smart-parens)
