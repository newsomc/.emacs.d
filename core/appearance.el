(require 'linum)

(defalias 'yes-or-no-p 'y-or-n-p)

;; wrap lines
(global-visual-line-mode 1)

;; winner-mode
(winner-mode 1)

(setq visual-line-fringe-indicators
      '(left-curly-arrow right-curly-arrow))

(setq color-theme-is-global t
      column-number-mode t
      fill-column 80
      font-lock-maximum-decoration t
      line-number-mode t
      linum-format "%3d "
      truncate-partial-width-windows nil
      visible-bell nil
      whitespace-line-column 100
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default indicate-empty-lines t)
(setq-default truncate-lines t)

(set-face-attribute 'linum nil :background "#222")
(set-face-foreground 'font-lock-warning-face "#ff6666")

(show-paren-mode 1)

(provide 'appearance)
