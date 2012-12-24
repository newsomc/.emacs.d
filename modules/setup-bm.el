(setq bm-restore-repository-on-load t)

(require 'bm)

(setq-default bm-buffer-persistence t)
(setq-default bm-persistent-face
  '(:foreground "#222222" :background "#b5bd68"))

(add-hook' after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)

(add-hook 'kill-emacs-hook '(lambda nil
  (bm-buffer-save-all)
  (bm-repository-save)))

(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

(global-set-key (kbd "<f2>") 'bm-toggle)

(provide 'setup-bm)
