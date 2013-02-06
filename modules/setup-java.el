(add-hook 'java-mode-hook (lambda ()
  (define-key java-mode-map (kbd "M-q") 'save-buffers-kill-terminal)))

(provide 'setup-java)
