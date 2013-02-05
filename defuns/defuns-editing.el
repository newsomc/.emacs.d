(defun camelize-buffer ()
  (interactive)
  (goto-char 0)
  (ignore-errors
    (replace-next-underscore-with-camel 0))
  (goto-char 0))

(defun change-number-at-point (arg)
  (interactive "p")
  (unless (or (looking-at "[0-9]")
              (looking-back "[0-9]"))
    (error "No number to change at point"))
  (while (looking-back "[0-9]")
    (forward-char -1))
  (re-search-forward "[0-9]+" nil)
  (replace-match (incs (match-string 0) arg) nil nil))

(defun comment-kill-all ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (comment-kill (save-excursion
                    (goto-char (point-max))
                    (line-number-at-pos)))))

(defun copy-line (arg)
  "Copy to end of line, or as many lines as prefix argument"
  (interactive "P")
  (if (null arg)
      (copy-to-end-of-line)
    (copy-whole-lines (prefix-numeric-value arg))))

(defun copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point)
                  (line-end-position))
  (message "Copied to end of line"))

(defun copy-whole-lines (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun css-contract-statement ()
  (interactive)
  (end-of-line)
  (search-backward "{")
  (while (not (looking-at "}"))
    (join-line -1))
  (back-to-indentation))

(defun css-expand-statement ()
  (interactive)
  (save-excursion
    (end-of-line)
    (search-backward "{")
    (forward-char 1)
    (let ((beg (point)))
      (newline)
      (er/mark-inside-pairs)
      (replace-regexp ";" ";\n" nil (region-beginning) (region-end))
      (indent-region beg (point)))))

(defun current-quotes-char ()
  (nth 3 (syntax-ppss)))

(defalias 'point-is-in-string-p 'current-quotes-char)

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

(defun incs (s &optional num)
  (number-to-string (+ (or num 1) (string-to-number s))))

(defun insert-tab ()
  (interactive)
  (insert "  "))

(defun join-line-below ()
  (interactive)
  (join-line -1))

(defun join-line-or-lines-in-region-up ()
  "Join this line or the lines in the selected region."
  (interactive)
  (cond ((region-active-p)
         (let ((min (line-number-at-pos (region-beginning))))
           (goto-char (region-end))
           (while (> (line-number-at-pos) min)
             (join-line))))
        (t (call-interactively 'join-line))))

(defun join-line-or-lines-in-region-down ()
  "Join this line or the lines in the selected region."
  (interactive)
  (cond ((region-active-p)
         (let ((min (line-number-at-pos (region-beginning))))
           (goto-char (region-end))
           (while (> (line-number-at-pos) min)
             (join-line))))
        (t (call-interactively 'join-line-below))))

(defun kill-and-retry-line ()
  "Kill the entire current line and reposition point at indentation"
  (interactive)
  (back-to-indentation)
  (kill-line))

(defun kill-current-line (&optional n)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (let ((kill-whole-line t))
      (kill-line n))))

(defun kill-region-or-backward-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-region (save-excursion (beginning-of-line) (point))
               (point)))

(defun malko/mark-all-in-region (beg end)
  (interactive "r")
  (let ((search (read-from-minibuffer "Mark all in region: "))
        (case-fold-search nil))
    (if (> (length search) 1)
      (progn
        (mc/remove-fake-cursors)
        (goto-char beg)
        (while (search-forward search end t)
          (push-mark (match-beginning 0))
          (mc/create-fake-cursor-at-point))
        (let ((first (mc/furthest-cursor-before-point)))
          (if (not first)
              (error "Search failed for %S" search)
            (mc/pop-state-from-overlay first))))))
  (if (> (mc/num-cursors) 1)
      (multiple-cursors-mode 1)
    (multiple-cursors-mode 0)))

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

(defmacro malko/mark-lines-cmd (name &rest body)
  `(defun ,(intern (concat "malko/mark-lines-" name)) ()
    (interactive)
    (malko/mark-lines)
    (add-hook 'malko/mark-lines-hook (lambda ()
      ,@body))))

(malko/mark-lines-cmd "mark")

(malko/mark-lines-cmd "cut"
  (call-interactively 'kill-region)
  (delete-blank-lines))

(malko/mark-lines-cmd "delete"
  (call-interactively 'delete-region)
  (delete-blank-lines))

(malko/mark-lines-cmd "copy"
  (call-interactively 'kill-ring-save)
  (malko/mark--jump-back))

(malko/mark-lines-cmd "paste"
  (call-interactively 'kill-ring-save)
  (malko/mark--jump-back)
  (yank))

(malko/mark-lines-cmd "comment"
  (call-interactively 'comment-or-uncomment-region)
  (malko/mark--jump-back))

(malko/mark-lines-cmd "multifile"
  (call-interactively 'mf/mirror-region-in-multifile)
  (malko/mark--jump-back))

(malko/mark-lines-cmd "indent"
  (call-interactively 'indent-region)
  (malko/mark--jump-back))

(malko/mark-lines-cmd "fold-this"
  (call-interactively 'fold-this-all)
  (malko/mark--jump-back))

(malko/mark-lines-cmd "mark-all-in-region"
  (call-interactively 'mc/mark-all-in-region))

;; /end custom functions using ace-jump mode

(defun move-backward-out-of-param ()
  (while (not (looking-back "(\\|, \\|{ ?\\|\\[ ?"))
    (cond
     ((point-is-in-string-p) (move-point-backward-out-of-string))
     ((looking-back ")\\|}\\|\\]") (backward-list))
     (t (backward-char)))))

(defun move-forward-out-of-param ()
  (while (not (looking-at ")\\|, \\| ?}\\| ?\\]"))
    (cond
     ((point-is-in-string-p) (move-point-forward-out-of-string))
     ((looking-at "(\\|{\\|\\[") (forward-list))
     (t (forward-char)))))

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

(defun move-point-backward-out-of-string ()
  (while (point-is-in-string-p) (backward-char)))

(defun move-point-forward-out-of-string ()
  (while (point-is-in-string-p) (forward-char)))

(defun new-line-in-between ()
  (interactive)
  (newline)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))

(defun replace-next-underscore-with-camel (arg)
  (interactive "p")
  (if (> arg 0)
      (setq arg (1+ arg))) ; 1-based index to get eternal loop with 0
  (let ((case-fold-search nil))
    (while (not (= arg 1))
      (search-forward-regexp "\\b_[a-z]")
      (forward-char -2)
      (delete-char 1)
      (capitalize-word 1)
      (setq arg (1- arg)))))

(defun save-region-or-current-line (arg)
  (interactive "P")
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (copy-line arg)))

(defun snakeify-current-word ()
  (interactive)
  (er/mark-word)
  (let* ((beg (region-beginning))
         (end (region-end))
         (current-word (buffer-substring-no-properties beg end))
         (snakified (snake-case current-word)))
    (replace-string current-word snakified nil beg end)))

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun transpose-params ()
  "Presumes that params are in the form (p, p, p) or {p, p, p} or [p, p, p]"
  (interactive)
  (let* ((end-of-first (cond
                        ((looking-at ", ") (point))
                        ((and (looking-back ",") (looking-at " ")) (- (point) 1))
                        ((looking-back ", ") (- (point) 2))
                        (t (error "Place point between params to transpose."))))
         (start-of-first (save-excursion
                           (goto-char end-of-first)
                           (move-backward-out-of-param)
                           (point)))
         (start-of-last (+ end-of-first 2))
         (end-of-last (save-excursion
                        (goto-char start-of-last)
                        (move-forward-out-of-param)
                        (point))))
    (transpose-regions start-of-first end-of-first start-of-last end-of-last)))

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

(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.

  \(fn arg char)"
    'interactive)
