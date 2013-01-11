;; font-lock
(add-font-lock-kw 'js2-mode "function" "\u0192")

(setq-default js2-allow-rhino-new-expr-initializer nil)
(setq-default js2-auto-indent-p nil)
(setq-default js2-bounce-indent-p t)
(setq-default js2-concat-multiline-strings 'eol)
(setq-default js2-enter-indents-newline nil)
(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_"
  "sinon" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval"
  "location" "__dirname" "console" "JSON"))
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-indent-on-enter-key nil)
(setq-default js2-include-gears-externs nil)
(setq-default js2-include-rhino-externs nil)
(setq-default js2-mirror-mode nil)
(setq-default js2-rebind-eol-bol-keys nil)
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-strict-missing-semi-warning nil)

(require 'js2-refactor)
(require 'js2-imenu-extras)
(js2-imenu-extras-setup)

;; tab characters
(setq js2-basic-offset 2)
(setq-default js2-basic-offset 2)

;; js2-mode steals TAB, let's steal it back for yasnippet
(defun js2-tab-properly ()
  (interactive)
  (let ((yas/fallback-behavior 'return-nil))
    (unless (yas/expand)
      (indent-for-tab-command)
      (if (looking-back "^\s*")
          (back-to-indentation)))))

(define-key js2-mode-map (kbd "TAB") 'js2-tab-properly)

;; don't redefine C-a for me please, js2-mode
(define-key js2-mode-map (kbd "C-a") nil)

(provide 'setup-js2-mode)
