(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-eclim/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-eclim/vendor"))

(require 'eclim)
(require 'eclimd)

(setq eclim-auto-save t)
(global-eclim-mode)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(add-hook 'java-mode-hook (lambda ()
  (define-key java-mode-map (kbd "M-q") 'save-buffers-kill-terminal)))

(provide 'setup-java)
