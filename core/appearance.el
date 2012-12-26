(require 'linum)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode 1)

(setq column-number-mode t)
(setq fill-column 80)
(setq line-number-mode t)
(setq linum-format "%3d ")
(setq whitespace-line-column 100)
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(setq-default truncate-lines t)
(set-face-attribute 'linum nil :background "#e9efff")
(set-face-background 'hl-line "#e9efff")

(show-paren-mode 1)

(provide 'appearance)
