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
(-each '("H-[" "C-j" "C-,"
         "<f3>" "<f4>" "<f5>" "<f6>" "<f7>" "<f8>" "<f9>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

;; rebind set mark to be more vim friendly
(define-key global-map (kbd "C-v") 'set-mark-command)

;; ace-jump-mode
(define-key global-map (kbd "C-SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-M-v") 'ace-jump-mode-pop-mark)

;; bookmark+
(global-set-key (kbd "C-j bd") 'icicle-bookmark-dired)
(global-set-key (kbd "C-j bl") 'icicle-bookmark)
(global-set-key (kbd "C-j bt") 'icicle-tag-a-file)
(global-set-key (kbd "C-j bT") 'icicle-untag-a-file)

;; browse-kill-ring
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

;; buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x rq") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-j k") 'kill-and-close-buffer)
(global-set-key (kbd "C-j C-k") 'delete-current-buffer-file)

(global-set-key (kbd "C-c n") 'cleanup-buffer)
(global-set-key (kbd "C-c N") 'cleanup-buffer-safe)
(global-set-key (kbd "C-c C-<return>") 'delete-blank-lines)

;; change-inner
(global-set-key (kbd "C-j C-i") 'change-inner)
(global-set-key (kbd "C-j C-o") 'change-outer)

;; dired
(global-set-key (kbd "C-x C-j") 'dired-jump) (autoload 'dired-jump "dired")
(global-set-key (kbd "C-x M-j") '(lambda () (interactive) (dired-jump 1)))

;; elisp-slime-nav
;;  M-. / M-, or M-*

;; eval-elisp
(global-set-key (kbd "C-j eb") 'eval-buffer)

;; expand-region
(global-set-key (kbd "C-;") 'er/expand-region)
(global-set-key (kbd "C-'") 'er/contract-region)

;; find files
(global-set-key (kbd "C-j fd") 'find-name-dired)
(global-set-key (kbd "C-j ff") 'find-file-in-project)

;; follow-mode
(global-set-key (kbd "C-j fm") 'follow-mode)
(global-set-key (kbd "C-j fe") 'next-error-follow-minor-mode)

;; grep
(global-set-key (kbd "C-j gg") 'ag-fullscreen)
(global-set-key (kbd "C-j gk") 'malko/kill-grep)
(global-set-key (kbd "C-j gw") 'ag-fullscreen-current-word)

(global-set-key (kbd "M-i") 'malko/step-in)
(global-set-key (kbd "M-o") 'malko/step-out)

;; hippie-expand
(global-set-key (kbd "C-.") 'hippie-expand-no-case-fold)
(global-set-key (kbd "C->") 'hippie-expand-lines)

;; icicles
(global-set-key (kbd "H-[ <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-j <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-, <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "M-s <backtab>") 'icicle-complete-keys)

;; iedit - interactive text replacement
(global-set-key (kbd "C-j C-r") 'iedit-mode)

;; lines
(define-key global-map (kbd "C-j ll") 'ace-jump-line-mode)
(define-key global-map (kbd "C-j lx") 'malko/mark-lines-cut)
(define-key global-map (kbd "C-j ld") 'malko/mark-lines-delete)
(define-key global-map (kbd "C-j lc") 'malko/mark-lines-copy)
(define-key global-map (kbd "C-j lv") 'malko/mark-lines-paste)
(define-key global-map (kbd "C-j lm") 'malko/mark-lines-comment)
(define-key global-map (kbd "C-j lf") 'malko/mark-lines-multifile)

;; lisp
(global-set-key (kbd "C-j ;") 'eval-expression)

;; logging
(global-set-key (kbd "C-j mm") 'malko/log-messages-on)
(global-set-key (kbd "C-j mo") 'malko/log-messages-off)

;; jump-char
(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

;; ido
(global-set-key (kbd "C-x f") 'ido-recentf-open)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; mac-friendly
(global-set-key (kbd "M-c") 'kill-ring-save) ;; subword-capitalize
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)
(global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "M-Z") 'undo-tree-redo)

;; macros
(global-set-key [f10]  'start-kbd-macro)
(global-set-key [f11]  'end-kbd-macro)
(global-set-key [f12]  'call-last-kbd-macro)

;; multiple-cursors
(global-set-key (kbd "C-j cl") 'mc/edit-lines)
(global-set-key (kbd "C-j ce") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-j ca") 'mc/edit-beginnings-of-lines)

;; occur
(global-set-key (kbd "C-j oo") 'occur)
(global-set-key (kbd "C-j om") 'multi-occur)
(global-set-key (kbd "C-j ob") 'multi-occur-in-all-open-buffers)

(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

;; perspectives
(define-key persp-mode-map (kbd "C-j pe") 'custom-persp/emacs)
(define-key persp-mode-map (kbd "C-j pi") 'custom-persp/instajams)
(define-key persp-mode-map (kbd "C-j pp") 'custom-persp-last)
(define-key persp-mode-map (kbd "C-j ps") 'project-switcher)

(define-key ibuffer-mode-map (kbd "/p") 'ibuffer-filter-by-perspective-filter)

;; regular expressions
(global-set-key (kbd "C-j re") 're-builder)

;; return/tab
(global-set-key (kbd "M-<return>") 'vi-open-line-below)
(global-set-key (kbd "C-<return>") 'vi-open-line-above)
(global-set-key (kbd "C-M-<return>") 'vi-open-line-above)

;; scratch js buffer
(global-set-key (kbd "C-j sj") 'create-scratch-js-buffer)

;; smex
;;  C-s/C-r [switches to the next/previous match]
;;  C-h f [describe-function]
;;  C-h w [where-is]
;;  M-. [jumps to the definition]
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; speedbar
(global-set-key (kbd "C-j C-j") 'sr-speedbar-toggle)

;; transpose
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; undo-tree
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)
(global-set-key (kbd "C--") 'undo-tree-undo)
(global-set-key (kbd "C-_") 'undo-tree-undo)
(global-set-key (kbd "M--") 'undo-tree-redo)
(global-set-key (kbd "M-_") 'undo-tree-redo)
(global-set-key (kbd "C-M--") 'undo-tree-redo)
(global-set-key (kbd "C-M-z") 'undo-tree-redo)
(global-set-key (kbd "C-M-Z") 'undo-tree-redo)

;; vim - help with transition
(global-set-key (kbd "C-, be") 'list-existing-buffers)
(global-set-key (kbd "C-, ff") 'ag-fullscreen)

(global-set-key (kbd "C-, C-g") 'ag-fullscreen)
(global-set-key (kbd "C-, C-p") 'project-switcher)
(global-set-key (kbd "C-, C-t") 'find-file-in-project)

;; window movement
(global-set-key (kbd "C-x C-o") 'switch-to-next-window)

(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)

;; yasnippet
(global-set-key (kbd "C-j se") 'yas-visit-snippet-file)
(global-set-key (kbd "C-j si") 'yas-insert-snippet)
(global-set-key (kbd "C-j sl") 'yas-describe-tables)
(global-set-key (kbd "C-j sn") 'yas-create-new-snippet)
(global-set-key (kbd "C-j sr") 'yas-reload-all)

(provide 'key-bindings)
