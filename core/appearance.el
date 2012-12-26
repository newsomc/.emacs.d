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
(setq-default indent-tabs-mode nil)
(set-default 'tab-width 2)
(setq-default tab-width 2)
(set-default 'indicate-empty-lines t)
(setq-default indicate-empty-lines t)
(set-default 'truncate-lines t)
(setq-default truncate-lines t)

(set-face-attribute 'linum nil :background "#333")
(set-face-background 'hl-line "#333")

(show-paren-mode 1)

(provide 'appearance)
