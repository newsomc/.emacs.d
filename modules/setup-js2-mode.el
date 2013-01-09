;; font-lock
(add-font-lock-kw 'js2-mode "function" "\u0192")

(setq-default js2-enter-indents-newline nil)
(setq-default js2-indent-on-enter-key nil)
(setq-default js2-strict-missing-semi-warning nil)

(provide 'setup-js2-mode)
