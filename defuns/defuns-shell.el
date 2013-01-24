(malko/create-buffer-specific-cmds "run-shell-cmds" "*run-shell-cmds*")

(defun malko/run-shell-commands (&rest commands)
  (let ((proc (get-buffer-process (current-buffer-name))))
    (dolist (cmd commands)
      (term-simple-send proc cmd))))

(defun malko/open-term (cmd)
  (interactive
    (let ((string (read-string "Command: " nil 'my-history)))
      (list string)))
  (malko/kill-run-shell-cmds)
  (split-window-below)
  (windmove-down)
  (halve-current-window-height)
  (ansi-term "/bin/bash" "run-shell-cmds")
  (malko/setup-term-mode-map)
  (visual-line-mode -1)
  (malko/run-shell-commands "PROMPT_COMMAND=\"PS1='> '\""
                            "clear"
                            cmd))

(defun malko/setup-term-mode-map ()
  (when (term-in-char-mode)
    (use-local-map term-old-mode-map)))

(defun malko/bind-term-cmd (cmd)
  (interactive
    (let ((string (read-string "Command: " nil 'my-history)))
      (list string)))
  (setq bind--term-cmd cmd)
  (global-set-key (kbd "C-j C-,") '(lambda ()
    (interactive)
    (malko/open-term bind--term-cmd))))
