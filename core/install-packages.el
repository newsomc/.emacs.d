(defun init--install-packages ()
  (packages-install
   (cons 'ace-jump-mode melpa)
   (cons 'browse-kill-ring melpa)
   (cons 'dash melpa)
   (cons 'diminish melpa)
   (cons 'elisp-slime-nav melpa)
   (cons 'ido-ubiquitous melpa)
   (cons 'jump-char melpa)
   (cons 's melpa)
   (cons 'sicp melpa)
   (cons 'smex melpa)
   (cons 'undo-tree melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(provide 'install-packages)
