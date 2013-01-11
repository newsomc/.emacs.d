(add-hook 'lisp-interaction-mode-hook
  (lambda ()
    (local-unset-key (kbd "C-j"))))

(provide 'setup-lisp-mode)
