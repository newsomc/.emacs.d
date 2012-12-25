(global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-x m"))

(define-prefix-command 'C-h-map)
(global-set-key (kbd "C-h") 'C-h-map)

(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x C-b") 'list-existing-buffers)
(global-set-key (kbd "C-c o") 'switch-to-next-window)

(provide 'key-bindings)
