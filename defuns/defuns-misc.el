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

;; stepping in/out
(defun malko/step-in ()
  (interactive)
  (cond
    ((malko/grep-active?)
     (malko/next-error-and-close))
    (t
      (pop-to-mark-command))))

(defun malko/step-out ()
  (interactive)
  (cond
    ((malko/grep-active?)
     (malko/previous-error-and-close))
    (t
      (unpop-to-mark-command))))

;; grep
(defun malko/grep-active? ()
  (-contains? (buffer-names) "*grep*"))

(defun malko/grep-visible? ()
  (-contains? (visible-buffer-names) "*grep*"))

(defun malko/kill-grep ()
  (interactive)
  (if (malko/grep-active?)
    (if (malko/grep-visible?)
      (progn
        (switch-to-window-by-name "*grep*")
        (kill-and-close-buffer))
      (kill-buffer "*grep*"))))

(defmacro malko/cycle-grep (name)
  `(defun ,(intern (format "malko/%s-error-and-close" name)) ()
    (interactive)
    (if (malko/grep-active?)
      (if (malko/grep-visible?)
        (progn
          (if (current-buffer-name-sw "*grep*")
            (progn
              (funcall ',(intern (format "%s-error" name))))
            (progn
              (kill-buffer (current-buffer))
              (delete-window)
              (funcall ',(intern (format "%s-error" name))))))
        (progn
          (switch-to-buffer "*grep*")
          (delete-other-windows)
          (funcall ',(intern (format "%s-error" name))))))))

(malko/cycle-grep "next")
(malko/cycle-grep "previous")

;; logging messages
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
