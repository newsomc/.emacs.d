(require 'imenu)

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (cleanup-buffer-safe)
  (indent-buffer))

(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))

(defun create-scratch-buffer nil
  "create a new scratch buffer to work in."
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)))

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun list-existing-buffers ()
  (interactive)
  (ibuffer-list-buffers)
  (other-window 1)
  (delete-other-windows))

(defun turn-off-whitespace ()
  (whitespace-mode nil))

(defun turn-on-whitespace ()
  (whitespace-mode t))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))
