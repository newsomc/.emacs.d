(require 'sr-speedbar)

(setq speedbar-hide-button-brackets-flag t
      speedbar-show-unknown-files t
      speedbar-smart-directory-expand-flag t
      speedbar-use-images nil
      speedbar-indentation-width 2
      speedbar-update-flag t
      sr-speedbar-auto-refresh t
      sr-speedbar-skip-other-window-p nil
      sr-speedbar-right-side t)

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; highlight the current line
(add-hook 'speedbar-mode-hook '(lambda () (hl-line-mode 1)))

;; more familiar keymap settings
(add-hook 'speedbar-reconfigure-keymaps-hook
          '(lambda ()
             (define-key speedbar-mode-map [M-up] 'speedbar-up-directory)
             (define-key speedbar-mode-map [right] 'speedbar-flush-expand-line)
             (define-key speedbar-mode-map [left] 'speedbar-contract-line)))

(define-key speedbar-mode-map (kbd "h") 'speedbar-up-directory)
(define-key speedbar-mode-map (kbd "j") 'speedbar-next)
(define-key speedbar-mode-map (kbd "k") 'speedbar-prev)
(define-key speedbar-mode-map (kbd "l") 'speedbar-flush-expand-line)
(define-key speedbar-mode-map (kbd "o") 'speedbar-edit-line)
(define-key speedbar-mode-map (kbd "C-j C-l") 'ace-jump-mode)
(define-key speedbar-mode-map (kbd "C-j ll") 'ace-jump-mode)

(provide 'setup-speedbar)
