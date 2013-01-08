(defun duplicate-current-line (num)
  "Duplicate the current line NUM times."
  (interactive "p")
  (when (eq (point-at-eol) (point-max))
    (goto-char (point-max))
    (newline)
    (forward-char -1))
  (duplicate-region num (point-at-bol) (1+ (point-at-eol))))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated."
  (interactive "p")
  (save-excursion
    (if (region-active-p)
        (duplicate-region arg)
      (duplicate-current-line arg))))

(defun duplicate-region (num &optional start end)
  "Duplicates the region bounded by START and END NUM times.
If no START and END is provided, the current region-beginning and
region-end is used. Adds the duplicated text to the kill ring."
  (interactive "p")
  (let* ((start (or start (region-beginning)))
         (end (or end (region-end)))
         (region (buffer-substring start end)))
    (kill-ring-save start end)
    (goto-char start)
    (dotimes (i num)
      (insert region))))

(defun insert-tab ()
  (interactive)
  (insert "  "))

(defun kill-current-line (&optional n)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (let ((kill-whole-line t))
      (kill-line n))))

;; custom functions using ace-jump mode

(defvar malko/mark-lines-hook nil
  "Function(s) to call after lines have been marked")

(defun malko/set-marks ()
  (setq malko/mark-point (point))
  (setq malko/mark-current-line (current-line))
  (setq malko/mark-current-column (current-column)))

(defun malko/mark-lines ()
  (setq malko/mark-lines-hook nil)
  (malko/set-marks)

  (ace-jump-line-mode)
  (add-hook 'post-command-hook 'malko/mark-lines--jump-one))

(defun malko/mark-lines--jump-one ()
  (if (eq this-command 'ace-jump-move)
    (progn
      (remove-hook 'post-command-hook 'malko/mark-lines--jump-one)
      (push-mark)
      (call-interactively 'set-mark-command)
      (ace-jump-line-mode)
      (add-hook 'post-command-hook 'malko/mark-lines--jump-two))
    (if (not (s-starts-with? "malko/mark-lines" (symbol-name this-command)))
      (remove-hook 'post-command-hook 'malko/mark-lines--jump-one))))

(defun malko/mark-lines--jump-two ()
  (if (eq this-command 'ace-jump-move)
    (progn
      (remove-hook 'post-command-hook 'malko/mark-lines--jump-two)
      (call-interactively 'move-end-of-line)
      (run-hooks 'malko/mark-lines-hook))
    (if (not (s-starts-with? "malko/mark-lines" (symbol-name this-command)))
      (remove-hook 'post-command-hook 'malko/mark-lines--jump-two))))

(defun malko/mark--jump-back ()
  (goto-line-and-column malko/mark-current-line
                        malko/mark-current-column))

(defun malko/mark-lines-copy ()
  (interactive)
  (malko/mark-lines)
  (add-hook 'malko/mark-lines-hook (lambda ()
    (call-interactively 'kill-ring-save)
    (malko/mark--jump-back)
    )))

(defun malko/mark-lines-paste ()
  (interactive)
  (malko/mark-lines)
  (add-hook 'malko/mark-lines-hook (lambda ()
    (call-interactively 'kill-ring-save)
    (malko/mark--jump-back)
    (yank)
    )))

(defun malko/mark-lines-comment ()
  (interactive)
  (malko/mark-lines)
  (add-hook 'malko/mark-lines-hook (lambda ()
    (call-interactively 'comment-or-uncomment-region)
    (malko/mark--jump-back)
    )))

;; /end custom functions using ace-jump mode

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(defun new-line-in-between ()
  (interactive)
  (newline)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))

(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(defun vi-open-line (&optional abovep)
  "Insert a newline below the current line and put point at beginning.
With a prefix argument, insert a newline above the current line."
  (interactive "P")
  (if abovep
      (vi-open-line-above)
    (vi-open-line-below)))
