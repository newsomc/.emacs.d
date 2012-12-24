(recentf-mode 1)

(setq recentf-max-saved-items 100)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(global-set-key (kbd "C-x f") 'ido-recentf-open)

(provide 'setup-recentf)
