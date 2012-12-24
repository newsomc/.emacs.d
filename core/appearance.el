(require 'linum)

(auto-compression-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-font-lock-mode t)
(global-hl-line-mode 1)
(global-linum-mode 1)

(setq column-number-mode t)
(setq delete-by-moving-to-trash t)
(setq echo-keystrokes 0.1)
(setq fill-column 80)
(setq line-number-mode t)
(setq linum-format "%3d ")
(setq shift-select-mode nil)
(setq whitespace-line-column 100)
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab))
(setq x-select-enable-clipboard t)

(set-face-attribute 'linum nil :background "#333")
(set-face-background 'hl-line "#333")

(show-paren-mode 1)

(provide 'appearance)
