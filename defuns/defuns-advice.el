(defun malko/fix-font-sizing ()
  (if (< (number-of-windows) 2)
    (font-size-big)
    (font-size-normal)))

(defadvice apply-macro-to-region-lines (around macro-fundamental activate)
  (let ((mode (current-major-mode)))
    (fundamental-mode)
    ad-do-it
    (call-interactively mode)))

(defadvice delete-other-windows (after reset-font-size activate)
  (font-size-big))

(defadvice jao-toggle-selective-display (after toggle-center activate)
  (recenter))

(defadvice kill-and-close-buffer (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice kill-window (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice malko/kill-help (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice malko/kill-occur (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice malko/kill-run-shell-cmds (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice rgrep-quit-window (after reset-font-size activate)
  (malko/fix-font-sizing))

(defadvice split-window-right (before reset-font-size activate)
  (font-size-normal))

(defadvice split-window-below (before reset-font-size activate)
  (font-size-normal))
