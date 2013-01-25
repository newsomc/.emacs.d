(load-file "~/.emacs.d/geiser-0.3/elisp/geiser.el")

(setq geiser-active-implementations '(racket))
(setq geiser-racket-binary
  "/Applications/Racket v5.3.1/bin/racket")
(setq geiser-repl-history-filename "~/.emacs.d/geiser-history")
(setq geiser-repl-startup-time 20000)

(eval-after-load 'geiser-repl
  '(progn
    (define-key geiser-repl-mode-map (kbd "C-<return>")
      'electrify-return-if-match)))

(provide 'setup-geiser)
