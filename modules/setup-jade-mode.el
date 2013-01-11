(autoload 'jade-mode "jade-mode")
(autoload 'sws-mode "sws-mode")

(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

(provide 'setup-jade-mode)
