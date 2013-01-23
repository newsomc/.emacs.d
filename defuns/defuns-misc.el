(require 'repeat)

(defun add-font-lock-kw (mode kw unicode)
  (let ((re (concat "\\(" kw "\\)")))
    (font-lock-add-keywords mode
                            `((,re (0 (progn (compose-region (match-beginning 1)
                                                             (match-end 1) ,unicode)
                                             nil)))))))

;; buffer local variables
(defmacro bvar (name value)
  `(set (make-local-variable ,name) ,value))

(defmacro bvarp (name value)
  `(progn
     (set (make-local-variable ,name) ,value)
     (put ,name 'permanent-local t)))

;; folding
(defun jao-toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (cond
    ((number-or-marker-p column)
     (bvar 'sd--column (1- (* 2 column)))
     sd--column)
    ((eq selective-display nil)
     (if (boundp 'sd--column) sd--column 1))
    (t nil))))

;; grep
(malko/create-buffer-specific-cmds "grep" "*grep*")

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

;; help
(malko/create-buffer-specific-cmds "help" "*Help*")
(malko/create-buffer-specific-cmds "tm-tests" "*tm-test*")

;; logging messages
(defun malko/switch-to-messages-buffer ()
  (interactive)
  (switch-to-buffer "*Messages*"))

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

;; macros
(defun malko/apply-macro-to-end-of-buffer ()
  (interactive)
  (unless (null last-kbd-macro)
    (save-excursion
      (beginning-of-line)
      (push-mark (point))
      (push-mark (point-max) nil t)
      (call-interactively 'apply-macro-to-region-lines))))

;; make repeatable commands
(defun make-repeatable-command (cmd)
  "Returns a new command that is a repeatable version of CMD.
The new command is named CMD-repeat.  CMD should be a quoted
command.

This allows you to bind the command to a compound keystroke and
repeat it with just the final key.  For example:

  (global-set-key (kbd \"C-c a\") (make-repeatable-command 'foo))

will create a new command called foo-repeat.  Typing C-c a will
just invoke foo.  Typing C-c a a a will invoke foo three times,
and so on."
  (fset (intern (concat (symbol-name cmd) "-repeat"))
        `(lambda ,(help-function-arglist cmd) ;; arg list
           ,(format "A repeatable version of `%s'." (symbol-name cmd))
           ,(interactive-form cmd) ;; interactive form
           ;; see also repeat-message-function
           (setq last-repeatable-command ',cmd)
           (repeat nil)))
  (intern (concat (symbol-name cmd) "-repeat")))

;; modes
(defun malko/toggle-glasses-mode ()
  (interactive)
  (call-interactively 'glasses-mode))

(defun noop ()
  (interactive)
  (message ""))

;; occur
(malko/create-buffer-specific-cmds "occur" "*Occur*")

(defun quiet (key)
  (global-set-key (read-kbd-macro key)
                  (lambda ()
                    (interactive)
                    (message ""))))

;; stepping in/out
(defun malko/step-in ()
  (interactive)
  (cond
   ((malko/grep-visible?)
    (malko/next-error-and-close))
   (t
    (call-interactively 'change-inner))))

(defun malko/step-out ()
  (interactive)
  (cond
   ((malko/grep-visible?)
    (malko/previous-error-and-close))
   (t
    (call-interactively 'change-outer))))
