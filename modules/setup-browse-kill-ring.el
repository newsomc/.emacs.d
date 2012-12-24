(require 'browse-kill-ring)

(setq browse-kill-ring-quit-action 'save-and-restore)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

(provide 'setup-browse-kill-ring)
