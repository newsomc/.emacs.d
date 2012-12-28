(setq bm-restore-repository-on-load t)

(require 'bm)

(setq-default bm-repository-size 1000)
(setq-default bm-repository-file "~/.emacs.d/.bm-repository")
(setq-default bm-buffer-persistence t)
(setq-default bm-persistent-face
  '(:foreground "#eee" :background "#8abeb7"))

(add-hook' after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)

(add-hook 'kill-emacs-hook '(lambda nil
  (bm-buffer-save-all)
  (bm-repository-save)))

(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

(provide 'setup-bm)
