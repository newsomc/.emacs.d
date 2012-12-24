(require 'linum)
(global-linum-mode 1)
(setq linum-format "%3d ")
(set-face-attribute 'linum nil :background "#333")

(setq line-number-mode t)
(setq column-number-mode t)
(setq fill-column 80)

(global-hl-line-mode 1)

(provide 'appearance)
