(setq bm-restore-repository-on-load t)

(require 'bm)

(setq-default bm-buffer-persistence t)
(setq-default bm-persistent-face
  '(:foreground "#333333" :background "#7099BC"))

(add-hook' after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)

(add-hook 'kill-emacs-hook '(lambda nil
  (bm-buffer-save-all)
  (bm-repository-save)))

(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

(global-set-key (kbd "C-h b b") 'bm-toggle)
(global-set-key (kbd "C-h b d") 'bm-remove-all-current-buffer)
(global-set-key (kbd "C-h b l") 'bm-show-all)
(global-set-key (kbd "C-h b n") 'bm-next)
(global-set-key (kbd "C-h b p") 'bm-previous)
(global-set-key (kbd "C-h b q") 'bm-remove-all-all-buffers)
(global-set-key (kbd "C-h b t") 'bm-toggle)

(provide 'setup-bm)
