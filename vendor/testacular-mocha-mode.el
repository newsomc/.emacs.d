(defvar tm-mode-map (make-sparse-keymap)
  "tm-mode keymap")

(defun tm-run-shell-commands (&rest commands)
  (let ((proc (get-buffer-process (current-buffer-name))))
    (dolist (cmd commands)
      (term-simple-send proc cmd))))

(defun tm-open-term (test-cmd)
  (interactive)
  (malko/kill-tm-tests)
  (split-window-below)
  (windmove-down)
  (halve-current-window-height)
  (let ((tm-git-base-path git-base-path))
    (ansi-term "/bin/bash" (tm-mode--compilation-buffer-name))
    (tm/setup-term-mode-map)
    (visual-line-mode -1)
    (tm-run-shell-commands "PROMPT_COMMAND=\"PS1='> '\""
                           "clear"
                           (tm-compile-command tm-git-base-path test-cmd))))

(defun tm-next-failure ()
  (interactive)
  (end-of-line)
  (search-forward "FAILED" nil t))

(defun tm-prev-failure ()
  (interactive)
  (beginning-of-line)
  (search-backward "FAILED" nil t))

(defun tm-compile-command (tm-git-base-path test-cmd)
  (format "cd %s; %s" tm-git-base-path test-cmd))

(defun tm-run-all-tests ()
  (interactive)
  (tm-open-term "make test"))

(defun tm-run-test ()
  (interactive)
  (let ((spec-file
        (car (last (split-string (file-name-no-extension) "specs/")))))
    (cond
      ((s-contains? "public/apps/jam" (buffer-file-name))
       (tm-open-term (format "make jam_tests FILE=%s" spec-file)))
      ((s-contains? "public/apps/main" (buffer-file-name))
       (tm-open-term (format "make main_tests FILE=%s" spec-file))))))

(defun tm-jump-to-failure ()
  (interactive)
  (if (search-forward-regexp (concat "("
                                     "\\(/[\0-\377[:nonascii:]]*\\)"
                                     ":"
                                     "\\([0-9]+\\)"
                                     ":"
                                     "\\([0-9]+\\))") nil t)
    (let* ((file (replace-regexp-in-string "\n" "" (match-string 1)))
           (line (string-to-number
             (replace-regexp-in-string "\n" "" (match-string 2))))
           (column (string-to-number
             (replace-regexp-in-string "\n" "" (match-string 3)))))
      (message file)
      (windmove-up)
      (find-file file)
      (goto-line-and-column line column))))

(defun tm-switch-to-test-window ()
  (interactive)
  (switch-to-window-by-name "*tm-test*")
  (balance-windows))

(define-key tm-mode-map (kbd "C-j ta") 'tm-run-all-tests)
(define-key tm-mode-map (kbd "C-j ts") 'tm-switch-to-test-window)
(define-key tm-mode-map (kbd "C-j tt") 'tm-run-test)

(defun tm/setup-term-mode-map ()
  (when (term-in-char-mode)
    (use-local-map term-old-mode-map)
    (define-key term-old-mode-map (kbd "<return>") 'tm-jump-to-failure)
    (define-key term-old-mode-map (kbd "M-n") 'tm-next-failure)
    (define-key term-old-mode-map (kbd "M-p") 'tm-prev-failure)))

(defun tm-mode--compilation-buffer-name (&rest ignore) "tm-test")

(define-minor-mode testacular-mocha-mode
  "Testacular-Mocha mode" nil " TM" tm-mode-map)

;;;###autoload
(add-hook 'js2-mode-hook (lambda () (testacular-mocha-mode)))

(provide 'testacular-mocha-mode)
