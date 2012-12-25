(global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-x m"))

(-each '("<f2>" "<f3>" "<f4>" "<f5>" "<f6>" "<f7>"
         "<f8>" "<f9>" "<f10>" "<f11>" "<f12>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

(define-prefix-command 'C-h-map)
(global-set-key (kbd "C-h") 'C-h-map)

(global-set-key (kbd "C-c o") 'switch-to-next-window)

(global-set-key (kbd "C-h h a") 'command-apropos)
(global-set-key (kbd "C-h h f") 'describe-function)
(global-set-key (kbd "C-h h k") 'describe-key)
(global-set-key (kbd "C-h h m") 'describe-mode)
(global-set-key (kbd "C-h h t") 'help-with-tutorial)
(global-set-key (kbd "C-h h v") 'describe-variable)

(global-set-key (kbd "C-x C-b") 'list-existing-buffers)
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)

(provide 'key-bindings)
