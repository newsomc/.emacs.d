(require 'grep)

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

(defvar git-grep-switches "--extended-regexp -I -n"
  "Switches to pass to `git grep'.")

(defun git-grep-fullscreen (regexp &optional files dir confirm)
  (interactive
   (let* ((regexp (grep-read-regexp))
          (files (grep-read-files regexp))
          (files (if (string= "* .*" files) "*" files))
          (dir (read-directory-name "Base directory: "
                                    nil default-directory t))
          (confirm (equal current-prefix-arg '(4))))
     (list regexp files dir confirm)))
  (let ((command (format "cd %s && git --no-pager grep %s %s -e %S -- '%s' "
                         dir
                         git-grep-switches
                         (if (s-lowercase? regexp) " --ignore-case" "")
                         regexp
                         files))
        (grep-use-null-device nil))
    (when confirm
      (setq command (read-shell-command "Run git-grep: " command 'git-grep-history)))
    (window-configuration-to-register ?$)
    (grep command)
    (switch-to-buffer "*grep*")
    (delete-other-windows)
    (beginning-of-buffer)))

(defun rgrep-fullscreen (regexp &optional files dir confirm)
  "Open grep in full screen, saving windows."
  (interactive
   (progn
     (grep-compute-defaults)
     (cond
      ((and grep-find-command (equal current-prefix-arg '(16)))
       (list (read-from-minibuffer "Run: " grep-find-command
                                   nil nil 'grep-find-history)))
      ((not grep-find-template)
       (error "grep.el: No `grep-find-template' available"))
      (t (let* ((regexp (grep-read-regexp))
                (files (grep-read-files regexp))
                (dir (read-directory-name "Base directory: "
                                          nil default-directory t))
                (confirm (equal current-prefix-arg '(4))))
           (list regexp files dir confirm))))))
  (window-configuration-to-register ?$)
  (rgrep regexp files dir confirm)
  (switch-to-buffer "*grep*")
  (delete-other-windows)
  (beginning-of-buffer))

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