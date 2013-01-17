;; jump from/to test
(defun malko/jump-from-test ()
  (interactive)
  (if (boundp 'jump-from-test--pattern)
    (jf/jump-to-match jump-from-test--pattern)))

(defun malko/jump-to-test ()
  (interactive)
  (if (boundp 'jump-to-test--pattern)
    (jf/jump-to-match jump-to-test--pattern)))

(defun malko/jump-to-other-file ()
  (interactive)
  (if (malko/jump-to-test) nil (malko/jump-from-test)))

;; layouts

(defun malko/layouts-spec-and-file ()
  (interactive)
  (delete-other-windows)
  (malko/jump-to-test)
  (split-window-right)
  (other-window 1)
  (malko/jump-from-test)
  (other-window -1))
