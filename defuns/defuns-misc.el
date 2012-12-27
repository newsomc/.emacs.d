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
