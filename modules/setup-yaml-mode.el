(require 'yaml-mode)

(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'setup-yaml-mode)
