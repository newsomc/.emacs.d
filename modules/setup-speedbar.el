(require 'sr-speedbar)

(setq speedbar-hide-button-brackets-flag t
      speedbar-show-unknown-files t
      speedbar-smart-directory-expand-flag t
      speedbar-use-images nil
      speedbar-indentation-width 2
      speedbar-update-flag t
      sr-speedbar-auto-refresh t
      sr-speedbar-skip-other-window-p t
      sr-speedbar-right-side nil)

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

(define-key speedbar-mode-map (kbd "j") 'speedbar-next)
(define-key speedbar-mode-map (kbd "k") 'speedbar-prev)
(define-key speedbar-mode-map (kbd "C-j C-l") 'ace-jump-mode)
(define-key speedbar-mode-map (kbd "C-j ll") 'ace-jump-mode)

;; always use the last selected window for loading files from speedbar
(defvar last-selected-window
  (if (not (eq (selected-window) sr-speedbar-window))
      (selected-window)
    (other-window)))

(defadvice select-window (after remember-selected-window activate)
  "Remember the last selected window."
  (unless (or (eq (selected-window) sr-speedbar-window)
    (not (window-live-p (selected-window))))
    (setq last-selected-window (selected-window))))

(defun sr-speedbar-before-visiting-file-hook ()
  "Function that hooks `speedbar-before-visiting-file-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-before-visiting-tag-hook ()
  "Function that hooks `speedbar-before-visiting-tag-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-visiting-file-hook ()
  "Function that hooks `speedbar-visiting-file-hook'."
  (select-window last-selected-window))

(defun sr-speedbar-visiting-tag-hook ()
  "Function that hooks `speedbar-visiting-tag-hook'."
  (select-window last-selected-window))

(provide 'setup-speedbar)
