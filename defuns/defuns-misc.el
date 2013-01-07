(defun add-font-lock-kw (mode kw unicode)
  (let ((re (concat "\\(" kw "\\)")))
    (font-lock-add-keywords mode
      `((,re (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) ,unicode)
                       nil)))))))

(defun noop ()
  (interactive)
  (message ""))

(defun quiet (key)
  (global-set-key (read-kbd-macro key)
    (lambda ()
      (interactive)
      (message ""))))

(defun malko/log-messages-off ()
  (interactive)
  (message "Logging commands: (OFF)")
  (remove-hook 'post-command-hook 'malko/log-messages-on-hook))

(defun malko/log-messages-on ()
  (interactive)
  (message "Logging commands: (ON)")
  (remove-hook 'post-command-hook 'malko/log-messages-on-hook)
  (switch-to-buffer "*Messages*")
  (add-hook 'post-command-hook 'malko/log-messages-on-hook))

(defun malko/log-messages-on-hook ()
  (message "curr: %s, prev: %s"
    (symbol-name this-command)
    (symbol-name last-command)))
