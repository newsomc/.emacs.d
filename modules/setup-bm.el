(setq-default bm-repository-file "~/.emacs.d/.bm-repository")
(setq bm-restore-repository-on-load t)

(require 'bm)

(setq-default bm-repository-size 1000)
(setq-default bm-persistent-face
  '(:foreground "#2e3043" :background "#f9b529"))
(setq-default bm-buffer-persistence t)
(setq-default bm-cycle-all-buffers nil)
(setq-default bm-recenter t)

(defun bm--turn-on-cycle-buffers ()
  (interactive)
  (message "bookmark cycle buffers: (on)")
  (setq-default bm-cycle-all-buffers t))

(defun bm--turn-off-cycle-buffers ()
  (interactive)
  (message "bookmark cycle buffers: (off)")
  (setq-default bm-cycle-all-buffers nil))

(add-hook 'after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

(provide 'setup-bm)
