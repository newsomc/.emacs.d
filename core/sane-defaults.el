(require 'ido)
(require 'uniquify)

(auto-compression-mode t)
(global-font-lock-mode t)
(ido-mode t)
(recentf-mode 1)

(setq delete-by-moving-to-trash t)
(setq echo-keystrokes 0.1)
(setq recentf-max-saved-items 100)
(setq shift-select-mode nil)
(setq uniquify-buffer-name-style 'forward)
(setq x-select-enable-clipboard t)

(provide 'sane-defaults)
