;; globally unset keys
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-x m"))

;; quiet keys
(-each '("M-`") 'quiet)

;; globally remap keys
(global-set-key [remap goto-line] 'goto-line-with-feedback)

;; reclaim C-[
(define-key input-decode-map (kbd "C-[") (kbd "H-["))

;; leader keys
(-each '("C-t" "H-[" "C-j" "C-v" "C-,"
         "<f3>" "<f4>" "<f5>" "<f6>" "<f7>"
         "<f8>" "<f9>" "<f10>" "<f11>" "<f12>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

;; ace-jump-mode
(define-key global-map (kbd "C-v") 'ace-jump-char-mode)
(define-key global-map (kbd "C-S-v") 'ace-jump-mode-pop-mark)

;; bm
(global-set-key (kbd "<f2>") 'bm-toggle)
(global-set-key (kbd "C-<f2>") 'bm-next)
(global-set-key (kbd "M-<f2>") 'bm-previous)
(global-set-key (kbd "C-j bd") 'bm-remove-all-current-buffer)
(global-set-key (kbd "C-j bl") 'bm-show-all)
(global-set-key (kbd "C-j bq") 'bm-remove-all-all-buffers)

;; browse-kill-ring
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

;; buffers
(global-set-key (kbd "C-x C-b") 'list-existing-buffers)
(global-set-key (kbd "C-x rq") 'save-buffers-kill-terminal)

;; change-inner
(global-set-key (kbd "M-i") 'change-inner)
(global-set-key (kbd "M-o") 'change-outer)

;; elisp-slime-nav
;;  M-. / M-, or M-*

;; expand-region
(global-set-key (kbd "C-'") 'er/expand-region)

;; follow-mode
(global-set-key (kbd "C-j fm") 'follow-mode)

;; hippie-expand
(global-set-key (kbd "C-.") 'hippie-expand-no-case-fold)
(global-set-key (kbd "C->") 'hippie-expand-lines)

;; lisp
(global-set-key (kbd "C-j ;") 'eval-expression)

;; jump-char
(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

;; ido
(global-set-key (kbd "C-x f") 'ido-recentf-open)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; mac-friendly
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)
(global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "M-Z") 'undo-tree-redo)
(global-set-key (kbd "M-<return>") 'vi-open-line-below)
(global-set-key (kbd "M-S-<return>") 'vi-open-line-above)

;; regular expressions
(global-set-key (kbd "C-j re") 're-builder)

;; return/tab
(global-set-key (kbd "C-<return>") 'vi-open-line-below)
(global-set-key (kbd "C-S-<return>") 'vi-open-line-above)

;; smex
;;  C-s/C-r [switches to the next/previous match]
;;  C-h f [describe-function]
;;  C-h w [where-is]
;;  M-. [jumps to the definition]
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; undo-tree
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)
(global-set-key (kbd "C--") 'undo-tree-undo)
(global-set-key (kbd "C-_") 'undo-tree-undo)
(global-set-key (kbd "M--") 'undo-tree-redo)
(global-set-key (kbd "M-_") 'undo-tree-redo)
(global-set-key (kbd "C-M--") 'undo-tree-redo)
(global-set-key (kbd "C-M-z") 'undo-tree-redo)
(global-set-key (kbd "C-M-Z") 'undo-tree-redo)

;; window movement
(global-set-key (kbd "C-c o") 'switch-to-next-window)
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)

(provide 'key-bindings)
