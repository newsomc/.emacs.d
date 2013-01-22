(require 'compile)

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
  (let ((tm-git-base-path git-base-path))
    (ansi-term "/bin/bash" (tm-mode--compilation-buffer-name))
    (tm-run-shell-commands "PROMPT_COMMAND=\"PS1='> '\""
                           "clear"
                           (tm-compile-command tm-git-base-path test-cmd))))

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

(define-key tm-mode-map
  (kbd "C-j ta") 'tm-run-all-tests)

(define-key tm-mode-map
  (kbd "C-j tt") 'tm-run-test)

(defun tm-mode--compilation-buffer-name (&rest ignore)
  "*tm-test*")

(define-minor-mode testacular-mocha-mode
  "Testacular-Mocha mode" nil " TM" tm-mode-map
  (if testacular-mocha-mode
      (progn
        (add-to-list 'compilation-error-regexp-alist '("(\\([^: ]+\\):\\([0-9]+\\):\\([0-9]+\\))" 1 2 3))
        (set (make-local-variable 'compilation-buffer-name-function) 'tm-mode--compilation-buffer-name))))

;;;###autoload
(add-hook 'js2-mode-hook (lambda () (testacular-mocha-mode)))

(provide 'testacular-mocha-mode)
