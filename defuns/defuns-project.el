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
