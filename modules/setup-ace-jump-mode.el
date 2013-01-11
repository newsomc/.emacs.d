(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))

(setq ace-jump-mode-submode-list
  '(ace-jump-word-mode ace-jump-char-mode))

; (add-hook 'ace-jump-mode-end-hook (lambda () (push-mark)))

(provide 'setup-ace-jump-mode)
