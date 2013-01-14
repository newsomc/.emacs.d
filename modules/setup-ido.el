(require 'ido)

(ido-mode t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold t
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10
      ido-everywhere t)

(add-hook 'ido-setup-hook #'(lambda ()
  (define-key ido-completion-map (kbd "<return>")
    'ido-exit-minibuffer)
  (define-key ido-completion-map (kbd "<tab>")
    'ido-complete)
  (define-key ido-file-completion-map (kbd "C-w")
    'ido-delete-backward-updir)
  (define-key ido-file-completion-map (kbd "C-x C-w")
    'ido-copy-current-file-name)))

;; always rescan buffer for imenu
(set-default 'imenu-auto-rescan t)

(add-to-list 'ido-ignore-directories "node_modules")
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; fix ido-ubiquitous for newer packages
(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

(provide 'setup-ido)
