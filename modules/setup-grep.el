(require 'grep)
(require 'wgrep)

(defun ag-fullscreen (regexp &optional dir confirm)
  (interactive
   (if (boundp 'git-base-path)
     (let* ((regexp (read-string "Search for: "))
            (confirm (equal current-prefix-arg '(2))))
       (list regexp confirm))
     (let* ((regexp (read-string "Search for: "))
            (dir (read-directory-name "Base directory: "
                                    nil default-directory t))
            (confirm (equal current-prefix-arg '(3))))
       (list regexp dir confirm))
     ))
  (if (executable-find "ag")
    (if (>= (length regexp) 3)
      (let ((command (format "cd %s && ag --nogroup --literal %s %S"
                             (if (boundp 'git-base-path) git-base-path dir)
                             (if (s-lowercase? regexp) "--ignore-case" "")
                             regexp))
            (grep-use-null-device nil))
        (when confirm
          (setq command (read-shell-command "Run ag: " command 'ag-history)))
        (window-configuration-to-register ?$)
        (grep command)
        (switch-to-buffer "*grep*")
        (delete-other-windows)
        (beginning-of-buffer))
      (message "Whoops! Your search must contain 3 characters or more"))
    (message "Command not found: brew install the_silver_searcher")))

(defun ag-fullscreen-current-word ()
  (interactive)
  (if (current-word)
    (ag-fullscreen (current-word))))

(defun rgrep-goto-file-and-close-rgrep ()
  (interactive)
  (compile-goto-error)
  (kill-buffer "*grep*")
  (delete-other-windows)
  (message "Type C-x r j $ to return to pre-rgrep windows."))

(defun rgrep-quit-window ()
  (interactive)
  (kill-buffer)
  (jump-to-register ?$))

(eval-after-load "grep"
  '(progn
     (add-to-list 'grep-find-ignored-directories "target")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "vendor")

     (define-key grep-mode-map "q" 'rgrep-quit-window)
     (define-key grep-mode-map (kbd "C-<return>") 'rgrep-goto-file-and-close-rgrep)
     (define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

     (setq wgrep-enable-key "e")))

(provide 'setup-grep)
