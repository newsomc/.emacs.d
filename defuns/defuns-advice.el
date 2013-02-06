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

(defadvice split-window-right (before reset-font-size activate)
  (font-size-normal))

(defadvice split-window-below (before reset-font-size activate)
  (if (not (eq this-command 'save-buffer))
    (font-size-normal)))

(defmacro malko/create-font-sizing-advice (name)
  `(defadvice ,(intern name) (after reset-font-size activate)
    (malko/fix-font-sizing)))

(malko/create-font-sizing-advice "custom-persp-last")
(malko/create-font-sizing-advice "kill-and-close-buffer")
(malko/create-font-sizing-advice "kill-window")
(malko/create-font-sizing-advice "magit-quit-session")
(malko/create-font-sizing-advice "malko/kill-help")
(malko/create-font-sizing-advice "malko/kill-occur")
(malko/create-font-sizing-advice "malko/kill-run-shell-cmds")
(malko/create-font-sizing-advice "project-switcher")
(malko/create-font-sizing-advice "rgrep-quit-window")
