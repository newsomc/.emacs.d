;; jade, stylus (sws = significant whitespace)
(autoload 'sws-mode "sws-mode")
(autoload 'jade-mode "jade-mode")
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; yaml
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'mode-mappings)
