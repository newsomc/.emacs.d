(defun init--install-packages ()
  (packages-install
   (cons 'ace-jump-mode melpa)
   (cons 'dash melpa)
   (cons 's melpa)
   (cons 'smex melpa)
   (cons 'undo-tree melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(provide 'install-packages)
