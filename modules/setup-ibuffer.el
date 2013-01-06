(require 'ibuffer)
(require 'ibuf-ext)

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-hook (lambda ()
  (ibuffer-auto-mode 1)
  (ibuffer-filter-disable)
  (if (boundp 'persp-curr)
    (ibuffer-filter-by-perspective-filter (persp-name persp-curr)))
  (ibuffer-perspective-list)))

(provide 'setup-ibuffer)
