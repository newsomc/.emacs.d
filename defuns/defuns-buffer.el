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

(defun list-existing-buffers ()
  (interactive)
  (ibuffer-list-buffers)
  (other-window 1)
  (delete-other-windows))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))
