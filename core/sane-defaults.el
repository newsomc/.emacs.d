(require 'uniquify)

(auto-compression-mode t)
(eldoc-mode)
(global-font-lock-mode t)

(setq delete-by-moving-to-trash t)
(setq echo-keystrokes 0.1)
(setq shift-select-mode nil)
(setq uniquify-buffer-name-style 'forward)
(setq x-select-enable-clipboard t)

(provide 'sane-defaults)
