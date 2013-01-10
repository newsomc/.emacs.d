(require 'sr-speedbar)

(setq speedbar-use-images nil)

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

(provide 'setup-speedbar)
