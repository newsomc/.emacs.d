(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-x m"))

(global-set-key [remap goto-line] 'goto-line-with-feedback)

(-each '("C-h" "C-j"
         "<f2>" "<f3>" "<f4>" "<f5>" "<f6>" "<f7>"
         "<f8>" "<f9>" "<f10>" "<f11>" "<f12>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

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
(global-set-key (kbd "C-h ;") 'eval-expression)

(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)

(global-set-key (kbd "C-x C-b") 'list-existing-buffers)
(global-set-key (kbd "C-x rq") 'save-buffers-kill-terminal)

;; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; bm
(global-set-key (kbd "C-h bb") 'bm-toggle)
(global-set-key (kbd "C-h bd") 'bm-remove-all-current-buffer)
(global-set-key (kbd "C-h bl") 'bm-show-all)
(global-set-key (kbd "C-h bn") 'bm-next)
(global-set-key (kbd "C-h bp") 'bm-previous)
(global-set-key (kbd "C-h bq") 'bm-remove-all-all-buffers)
(global-set-key (kbd "C-h bt") 'bm-toggle)

;; browse-kill-ring
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

;; jump-char
(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

;; ido
(global-set-key (kbd "C-x f") 'ido-recentf-open)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-x m") 'smex)

(provide 'key-bindings)
