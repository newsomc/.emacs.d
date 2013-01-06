(require 'ibuffer)
(require 'ibuf-ext)

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-hook (lambda ()
  (ibuffer-perspective-list)))

(provide 'setup-ibuffer)
