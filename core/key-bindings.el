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
(-each '("C-q" "C-r" "H-[" "C-s" "C-j" "C-z" "C-,"
         "<f2>" "<f3>" "<f4>" "<f5>" "<f6>" "<f7>" "<f8>" "<f9>")
       (lambda (key)
         (global-unset-key (read-kbd-macro key))
         (define-prefix-command (intern (concat key "-map")))
         (global-set-key (read-kbd-macro key) (intern (concat key "-map")))))

;; prefix binding
(defun c-pf-key (prefix key fun)
  (global-set-key (read-kbd-macro (concat "C-" prefix " " key)) fun)
  (global-set-key (read-kbd-macro (concat "C-" prefix " C-" key)) fun))

(defun h-pf-key (prefix key fun)
  (global-set-key (read-kbd-macro (concat "H-" prefix " " key)) fun)
  (global-set-key (read-kbd-macro (concat "H-" prefix " C-" key)) fun))

;; quoted insert since we use C-q as prefix key
(global-set-key "\C-x\C-q"  'quoted-insert)

;; rebind help apropos
(define-key help-map "a" 'apropos)

;; rebind set mark to be more vim friendly
(define-key global-map (kbd "C-v") 'set-mark-command)

;; fallback yasnippet trigger
(define-key global-map (kbd "C-c TAB") 'noop)

(global-set-key (kbd "C-9") '(lambda () (interactive) (insert "(")))
(global-set-key (kbd "C-0") '(lambda () (interactive) (insert ")")))

;; C-j C-... mappings
(global-set-key (kbd "C-j C-a") 'malko/apply-macro-to-end-of-buffer)
(global-set-key (kbd "C-j C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-j C-c") 'copy-whole-lines)
(global-set-key (kbd "C-j C-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-j C-e") 'ibuffer)
(global-set-key (kbd "C-j C-f") 'find-file-in-project)
(global-set-key (kbd "C-j C-g") 'ag-fullscreen)
(global-set-key (kbd "C-j C-h") 'malko/kill-help)
(global-set-key (kbd "C-j C-i") 'change-inner)
(global-set-key (kbd "C-j C-j") 'other-window)
(global-set-key (kbd "C-j C-k") 'set-mark-command)
(global-set-key (kbd "C-j C-l") 'ace-jump-line-mode)
(global-set-key (kbd "C-j C-o") 'change-outer)
(global-set-key (kbd "C-j C-p") 'project-switcher)
(global-set-key (kbd "C-j C-q") 'delete-other-windows)
(global-set-key (kbd "C-j C-r") 'mc/mark-all-like-this)
(global-set-key (kbd "C-j C-s") 'save-buffer)
(global-set-key (kbd "C-j C-t") 'sr-speedbar-toggle)
(global-set-key (kbd "C-j C-u") 'undo-tree-visualize)
(global-set-key (kbd "C-j C-v") 'magit-status)
(global-set-key (kbd "C-j C-w") 'switch-window)
(global-set-key (kbd "C-j C-y") 'malko/layouts-spec-and-file)
(global-set-key (kbd "C-j C-;") 'eval-expression)
(global-set-key (kbd "C-j H-[") 'hs-hide-all)
(global-set-key (kbd "C-j C-]") 'hs-show-all)
(global-set-key (kbd "C-j C-SPC") 'quick-switch-buffer)

;; C-q / H-[ / C-z / C-,
(h-pf-key "[" "[" (make-repeatable-command 'winner-undo))
(global-set-key (kbd "H-[ H-[") (make-repeatable-command 'winner-undo))
(h-pf-key "[" "]" 'winner-redo)

(c-pf-key "," "a" 'mc/edit-beginnings-of-lines)
(c-pf-key "," "e" 'mc/edit-ends-of-lines)
(c-pf-key "," "x" 'kill-region)
(c-pf-key "," "c" 'kill-ring-save)
(c-pf-key "," "d" 'duplicate-current-line-or-region)
(c-pf-key "," "m" 'mf/mirror-region-in-multifile)
(c-pf-key "," "i" 'indent-region)
(c-pf-key "," "/" 'comment-or-uncomment-region)
(c-pf-key "," "k" 'malko/mark-all-in-region)
(c-pf-key "," "f" 'fold-this-all)
(c-pf-key "," "r" 'align-regexp)

;; ace-jump-mode
(define-key global-map (kbd "C-SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-M-v") 'ace-jump-mode-pop-mark)

;; bm
(global-set-key (kbd "<f2>") 'bm-toggle)
(global-set-key (kbd "<f3>") 'bm-next)
(global-set-key (kbd "<f4>") 'bm-previous)
(global-set-key (kbd "C-<f3>") 'bm--turn-on-cycle-buffers)
(global-set-key (kbd "C-<f4>") 'bm--turn-off-cycle-buffers)

(global-set-key (kbd "C-j bj")
                (make-repeatable-command 'bm-next))
(global-set-key (kbd "C-j bk")
                (make-repeatable-command 'bm-previous))
(global-set-key (kbd "C-j bd") 'bm-remove-all-current-buffer)
(global-set-key (kbd "C-j bD") 'bm-remove-all-all-buffers)
(global-set-key (kbd "C-j bl") 'bm-show-all)

;; browse-kill-ring
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

;; buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x rq") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-j K") 'delete-current-buffer-file)

(global-set-key (kbd "C-c N") 'cleanup-buffer)
(global-set-key (kbd "C-c n") 'cleanup-buffer-safe)
(global-set-key (kbd "C-c C-<return>") 'delete-blank-lines)

;; commands (shell)
(global-set-key (kbd "C-j cc") 'shell-command-on-whole-buffer)

;; comment
(global-set-key (kbd "M-/") 'toggle-comment-on-line)

;; ctags
(global-set-key (kbd "C-j cu") 'build-ctags)
(global-set-key (kbd "M-.") 'malko/find-tag)
(global-set-key (kbd "C-M-.") 'malko/ido-find-tag)

;; debug
(global-set-key (kbd "C-j dc") 'cancel-debug-on-entry)
(global-set-key (kbd "C-j dd") 'debug-on-entry)

;; dired
(global-set-key (kbd "C-x C-j") 'dired-jump) (autoload 'dired-jump "dired")
(global-set-key (kbd "C-x M-j") '(lambda () (interactive) (dired-jump 1)))

;; elisp-slime-nav
;;  M-. / M-, or M-*

;; eval-elisp
(global-set-key (kbd "C-j eb") 'eval-buffer)
(global-set-key (kbd "C-j ee") 'eval-defun)
(global-set-key (kbd "C-j ei") 'ielm)
(global-set-key (kbd "C-j er") 'eval-region)

;; evil-numbers
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c =") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
(global-set-key (kbd "C-c _") 'evil-numbers/dec-at-pt)

;; expand-region
(global-set-key (kbd "C-;") 'er/expand-region)
(global-set-key (kbd "M-;") 'er/expand-region) ;; comment-dwim
(global-set-key (kbd "C-'") 'er/contract-region)
(global-set-key (kbd "M-'") 'er/contract-region) ;; abbrev-prefix-mark

;; find files
(global-set-key (kbd "C-j fd") 'find-name-dired)
(global-set-key (kbd "C-j ff") 'find-file-in-project)

(global-set-key (kbd "C-j C-n cc")
                (ffip-create-pattern-file-finder "*.c" "*.h"))
(global-set-key (kbd "C-j C-n cl")
                (ffip-create-pattern-file-finder "*.clj"))
(global-set-key (kbd "C-j C-n co")
                (ffip-create-pattern-file-finder "*.coffee"))
(global-set-key (kbd "C-j C-n cs")
                (ffip-create-pattern-file-finder "*.css" "*.styl"))
(global-set-key (kbd "C-j C-n el")
                (ffip-create-pattern-file-finder "*.el"))
(global-set-key (kbd "C-j C-n er")
                (ffip-create-pattern-file-finder
                  "*.erl" "*.source" "*.config" "*.escript"))
(global-set-key (kbd "C-j C-n ex")
                (ffip-create-pattern-file-finder "*.ex" "*.exs"))
(global-set-key (kbd "C-j C-n go")
                (ffip-create-pattern-file-finder "*.go"))
(global-set-key (kbd "C-j C-n hj")
                (ffip-create-pattern-file-finder "*.html" "*.jade"))
(global-set-key (kbd "C-j C-n hs")
                (ffip-create-pattern-file-finder "*.hs" "*.cabal"))
(global-set-key (kbd "C-j C-n ja")
                (ffip-create-pattern-file-finder "*.java"))
(global-set-key (kbd "C-j C-n js")
                (ffip-create-pattern-file-finder "*.js"))
(global-set-key (kbd "C-j C-n ml")
                (ffip-create-pattern-file-finder "*.ml"))
(global-set-key (kbd "C-j C-n py")
                (ffip-create-pattern-file-finder "*.py"))
(global-set-key (kbd "C-j C-n rb")
                (ffip-create-pattern-file-finder "*.rb"))
(global-set-key (kbd "C-j C-n rk")
                (ffip-create-pattern-file-finder "*.rkt" "*.scrbl"))
(global-set-key (kbd "C-j C-n sc")
                (ffip-create-pattern-file-finder "*.scala"))
(global-set-key (kbd "C-j C-n sh")
                (ffip-create-pattern-file-finder "*.sh" "Makefile"))
(global-set-key (kbd "C-j C-n sm")
                (ffip-create-pattern-file-finder "*.scm"))
(global-set-key (kbd "C-j C-n xm")
                (ffip-create-pattern-file-finder "*.xml"))

;; folding
(global-set-key (kbd "C-j zz") 'fold-this-unfold-all)
(global-set-key [f1] 'jao-toggle-selective-display)

(global-set-key (kbd "C-j zt") 'hs-toggle-hiding) ;; hide-show
(global-set-key (kbd "C-j zM") 'hs-hide-all)
(global-set-key (kbd "C-j zm") 'hs-hide-block)
(global-set-key (kbd "C-j zR") 'hs-show-all)
(global-set-key (kbd "C-j zr") 'hs-show-block)

;; follow-mode
(global-set-key (kbd "C-j fm") 'follow-mode)
(global-set-key (kbd "C-j fe") 'next-error-follow-minor-mode)

;; font-size
(global-set-key (kbd "C-j =") 'font-size-big)
(global-set-key (kbd "C-j C-=") 'font-size-big)
(global-set-key (kbd "C-j -") 'font-size-normal)
(global-set-key (kbd "C-j C--") 'font-size-normal)

;; grep
(global-set-key (kbd "C-j gg") 'ag-fullscreen-current-word)

(global-set-key (kbd "M-i") 'malko/step-in)
(global-set-key (kbd "M-o") 'malko/step-out)

;; help
(define-key help-mode-map (kbd "j") 'next-line)
(define-key help-mode-map (kbd "n") 'next-line)
(define-key help-mode-map (kbd "k") 'previous-line)
(define-key help-mode-map (kbd "p") 'previous-line)

;; hippie-expand
(global-set-key (kbd "C-.") 'hippie-expand-no-case-fold)
(global-set-key (kbd "C->") 'hippie-expand-lines)

;; ibuffer
(define-key ibuffer-mode-map (kbd "j") 'ibuffer-forward-line)
(define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line)

;; icicles
(global-set-key (kbd "H-[ <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-q <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-j <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-z <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "C-, <backtab>") 'icicle-complete-keys)
(global-set-key (kbd "M-s <backtab>") 'icicle-complete-keys)

;; ido
(global-set-key (kbd "C-x f") 'recentf-ido-find-file) ; ido-recentf-open
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; isearch
(global-set-key (kbd "C-/") 'isearch-forward)
(global-set-key (kbd "C-?") 'isearch-backward)

(define-key isearch-mode-map (kbd "C-n") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-p") 'isearch-repeat-backward)

(define-key isearch-mode-map (kbd "C-q") nil)
(define-key isearch-mode-map (kbd "C-j") nil)
(define-key isearch-mode-map (kbd "C-s") nil)
(define-key isearch-mode-map (kbd "C-r") nil)
(define-key isearch-mode-map (kbd "C-z") nil)
(define-key isearch-mode-map (kbd "H-[") nil)
(define-key isearch-mode-map (kbd "C-,") nil)

;; jump-char
(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-backward)

;; kill
(global-set-key (kbd "C-j ka") 'kill-to-beginning-of-line)
(global-set-key (kbd "C-j ke") 'kill-line)
(global-set-key (kbd "C-j kg") 'rgrep-quit-window)
(global-set-key (kbd "C-j kh") 'malko/kill-help)
(global-set-key (kbd "C-j kk") 'kill-and-close-buffer)
(global-set-key (kbd "C-j ko") 'malko/kill-occur)
(define-key persp-mode-map (kbd "C-j kp") 'persp-kill)
(global-set-key (kbd "C-j ks") 'malko/kill-run-shell-cmds)

;; layouts
(define-key global-map (kbd "C-j yy") 'malko/layouts-spec-and-file)

;; lines
(define-key global-map (kbd "C-a") 'beginning-of-line)
(define-key global-map (kbd "C-e") 'end-of-line)

(define-key global-map (kbd "C-j lw") 'mark-whole-buffer) ;; C-x h
(define-key global-map (kbd "C-j lj") 'join-line)

;; lisp
(global-set-key (kbd "C-c C-e") 'eval-and-replace)
(global-set-key (kbd "C-j ;") 'eval-expression)

;; logging
(global-set-key (kbd "C-j mm") 'malko/log-messages-on)
(global-set-key (kbd "C-j mo") 'malko/log-messages-off)
(global-set-key (kbd "C-j ms") 'malko/switch-to-messages-buffer)

;; mac-friendly
(global-set-key (kbd "M-c") 'kill-ring-save) ;; subword-capitalize
(global-set-key (kbd "M-j") 'join-line-or-lines-in-region-down)
(global-set-key (kbd "M-C-j") 'join-line-or-lines-in-region-up)
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)
(global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-w") 'delete-frame)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "M-Z") 'undo-tree-redo)

;; macros
(global-set-key [f10]  'start-kbd-macro)
(global-set-key [f11]  'end-kbd-macro)
(global-set-key [f12]  'call-last-kbd-macro)

;; modes
(c-pf-key "j C-m" "c" 'malko/toggle-glasses-mode)
(c-pf-key "j C-m" "h" 'malko/toggle-icy-mode)
(c-pf-key "j C-m" "s" 'malko/toggle-smartparens-mode)

;; move more quickly
(global-set-key (kbd "C-S-n") (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p") (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f") (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b") (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;; multiple-cursors
(global-set-key (kbd "C-j cl") 'mc/edit-lines)
(global-set-key (kbd "C-j ce") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-j ca") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-j cr") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-j >")
                (make-repeatable-command 'mc/mark-next-like-this))
(global-set-key (kbd "C-j <")
                (make-repeatable-command 'mc/mark-previous-like-this))

;; newline
(global-set-key (kbd "M-<return>") 'vi-open-line-below)
(global-set-key (kbd "C-<return>") 'vi-open-line-below)
(global-set-key (kbd "C-M-<return>") 'vi-open-line-above)
(global-set-key (kbd "M-S-<return>") 'vi-open-line-above)

;; occur
(global-set-key (kbd "C-j oo") 'occur)
(global-set-key (kbd "C-j om") 'multi-occur-in-all-open-buffers)
(global-set-key (kbd "C-j os") 'malko/switch-to-occur-buffer)

(define-key occur-mode-map (kbd "o") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "j") 'next-line)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "k") 'previous-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

;; perspectives
(define-key persp-mode-map (kbd "C-j pe") 'custom-persp/emacs)
(define-key persp-mode-map (kbd "C-j pi") 'custom-persp/instajams)
(define-key persp-mode-map (kbd "C-j pp") 'custom-persp-last)
(define-key persp-mode-map (kbd "C-j ps") 'persp-switch)

(define-key ibuffer-mode-map (kbd "/p") 'ibuffer-filter-by-perspective-filter)

;; regular expressions
(global-set-key (kbd "C-j re") 're-builder)

;; scratch js buffer
(global-set-key (kbd "C-j sj") 'create-scratch-js-buffer)

;; shell
(global-set-key (kbd "C-j a") 'malko/open-term)
(global-set-key (kbd "C-j '") 'malko/bind-term-cmd)

;; smex
;;  C-s/C-r [switches to the next/previous match]
;;  C-h f [describe-function]
;;  C-h w [where-is]
;;  M-. [jumps to the definition]
(global-set-key (kbd "C-r") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; transpose
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; undo-tree
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)
(global-set-key (kbd "C--") 'undo-tree-undo)
(global-set-key (kbd "C-_") 'undo-tree-redo)

;; windows
(global-set-key (kbd "C-x C-o") 'switch-window)
(global-set-key (kbd "C-x -") 'rotate-windows)
(global-set-key (kbd "C-x C--") 'toggle-window-split)
(global-set-key (kbd "C-j j") (make-repeatable-command 'other-window))
(global-set-key (kbd "C-j wr") 'reset-winner-mode)

(global-set-key (kbd "C-j [")
                (make-repeatable-command 'halve-current-window-height))
(global-set-key (kbd "C-j ]")
                (make-repeatable-command 'halve-other-window-height))
(global-set-key (kbd "C-j \\") 'balance-windows)

(-each '("C" "M" "S") (lambda (key)
                        (global-set-key (read-kbd-macro (concat key "-<up>")) 'windmove-up)
                        (global-set-key (read-kbd-macro (concat key "-<down>")) 'windmove-down)
                        (global-set-key (read-kbd-macro (concat key "-<left>")) 'windmove-left)
                        (global-set-key (read-kbd-macro (concat key "-<right>")) 'windmove-right)))

;; yasnippet
(global-set-key (kbd "C-j sc") 'yas-create-new-snippet)
(global-set-key (kbd "C-j se") 'yas-visit-snippet-file)
(global-set-key (kbd "C-j si") 'yas-insert-snippet)
(global-set-key (kbd "C-j sl") 'yas-describe-tables)
(global-set-key (kbd "C-j sn") 'yas-create-new-snippet)
(global-set-key (kbd "C-j sr") 'yas-reload-all)

(provide 'key-bindings)
