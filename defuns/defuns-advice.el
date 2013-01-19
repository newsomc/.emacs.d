(defadvice jao-toggle-selective-display (after toggle-center activate)
  (recenter))

(defadvice apply-macro-to-region-lines (around macro-fundamental activate)
  (let ((mode (current-major-mode)))
    (fundamental-mode)
    ad-do-it
    (call-interactively mode)))
