(require 'bookmark+)

(add-hook 'bookmark-bmenu-mode-hook
  (lambda ()
    (local-unset-key (kbd "M-c"))
    (local-unset-key (kbd "M-q"))
    (local-unset-key (kbd "C-<up>"))
    (local-unset-key (kbd "C-<down>"))))

(provide 'setup-bookmark-plus)
