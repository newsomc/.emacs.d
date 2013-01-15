(defun init--install-packages ()
  (packages-install
   (cons 'ace-jump-mode melpa)
   (cons 'auto-complete melpa)
   (cons 'bookmark+ melpa)
   (cons 'browse-kill-ring melpa)
   (cons 'change-inner melpa)
   (cons 'dash melpa)
   (cons 'deft melpa)
   (cons 'diminish melpa)
   (cons 'dired-details melpa)
   (cons 'elisp-slime-nav melpa)
   (cons 'eproject melpa)
   (cons 'exec-path-from-shell melpa)
   (cons 'expand-region melpa)
   (cons 'feature-mode melpa)
   (cons 'find-file-in-project melpa)
   (cons 'findr melpa)
   (cons 'fold-this melpa)
   (cons 'frame-cmds melpa)
   (cons 'frame-fns melpa)
   (cons 'geiser marmalade)
   (cons 'icicles melpa)
   (cons 'ido-ubiquitous melpa)
   (cons 'inflections melpa)
   (cons 'js2-mode melpa)
   (cons 'js2-refactor melpa)
   (cons 'jump melpa)
   (cons 'jump-char melpa)
   (cons 'key-chord melpa)
   (cons 'magit melpa)
   (cons 'maxframe melpa)
   (cons 'multifiles melpa)
   (cons 'multiple-cursors melpa)
   (cons 'paredit melpa)
   (cons 'perspective melpa)
   (cons 'pomodoro melpa)
   (cons 'popup melpa)
   (cons 'rainbow-delimiters melpa)
   (cons 's melpa)
   (cons 'sicp melpa)
   (cons 'simple-httpd melpa)
   (cons 'skewer-mode melpa)
   (cons 'smartparens melpa)
   (cons 'smex melpa)
   (cons 'sml-mode gnu)
   (cons 'smooth-scrolling melpa)
   (cons 'solarized-theme melpa)
   (cons 'sr-speedbar melpa)
   (cons 'undo-tree melpa)
   (cons 'wgrep melpa)
   (cons 'yaml-mode melpa)
   (cons 'yasnippet melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(provide 'install-packages)
