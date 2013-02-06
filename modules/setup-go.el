(require 'go-mode)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-font-lock-kw 'go-mode "func" "\u0192")

(provide 'setup-go)
