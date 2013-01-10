(require 'sr-speedbar)

(setq speedbar-use-images nil)

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

(define-key speedbar-mode-map (kbd "j") 'speedbar-next)
(define-key speedbar-mode-map (kbd "k") 'speedbar-prev)

(provide 'setup-speedbar)
