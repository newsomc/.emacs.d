(global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-x m"))

(global-set-key [remap goto-line] 'goto-line-with-feedback)

(-each '("<f2>" "<f3>" "<f4>" "<f5>" "<f6>" "<f7>"
         "<f8>" "<f9>" "<f10>" "<f11>" "<f12>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

(define-prefix-command 'C-h-map)
(global-set-key (kbd "C-h") 'C-h-map)

(global-set-key (kbd "C-c o") 'switch-to-next-window)

(global-set-key (kbd "C-h ha") 'command-apropos)
(global-set-key (kbd "C-h hc") 'describe-key-briefly)
(global-set-key (kbd "C-h hf") 'describe-function)
(global-set-key (kbd "C-h hk") 'describe-key)
(global-set-key (kbd "C-h hm") 'describe-mode)
(global-set-key (kbd "C-h ht") 'help-with-tutorial)
(global-set-key (kbd "C-h hv") 'describe-variable)
(global-set-key (kbd "C-h hw") 'where-is)

(global-set-key (kbd "C-]") 'er/expand-region)
(global-set-key (kbd "C-h ci") 'change-inner)
(global-set-key (kbd "C-h ca") 'change-outer)
(global-set-key (kbd "C-h l") 'goto-line)
(global-set-key (kbd "C-h re") 're-builder)

(global-set-key (kbd "C-x C-b") 'list-existing-buffers)
(global-set-key (kbd "C-x rq") 'save-buffers-kill-terminal)

(provide 'key-bindings)
