(require 'dired)
(require 'dired-x)
(require 'dash)

(setq-default dired-omit-files-p t)

;; make dired less verbose
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

;; reload dired after making changes
(--each '(dired-do-rename
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))

;; C-a is nicer in dired if it moves back to start of files
(defun dired-back-to-start-of-files ()
  (interactive)
  (backward-char (- (current-column) 2)))

;; M-up is nicer in dired if it moves to the third line - straight to the ".."
(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (dired-next-line (if dired-omit-mode 2 4)))

(define-key dired-mode-map
  (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
(define-key dired-mode-map
  (vector 'remap 'smart-up) 'dired-back-to-top)

;; M-down is nicer in dired if it moves to the last file
(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(define-key dired-mode-map
  (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
(define-key dired-mode-map
  (vector 'remap 'smart-down) 'dired-jump-to-bottom)

;; delete with C-x C-k to match file buffers and magit
(define-key dired-mode-map (kbd "SPC") 'dired-hide-subdir)
(define-key dired-mode-map (kbd "e") 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
(define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete)
(define-key dired-mode-map (kbd "M-<up>") 'dired-back-to-top)
(define-key dired-mode-map (kbd "M-<down>") 'dired-jump-to-bottom)
(define-key dired-mode-map (kbd "M-o") 'malko/step-out)
(define-key dired-mode-map (kbd "C-j C-l") 'ace-jump-mode)
(define-key dired-mode-map (kbd "C-j ll") 'ace-jump-mode)

;; wdired
(eval-after-load 'wdired
  '(progn
    (define-key wdired-mode-map (kbd "C-j") nil)
    (define-key wdired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
    (define-key wdired-mode-map (kbd "C-j C-l") 'ace-jump-mode)
    (define-key wdired-mode-map (kbd "C-j ll") 'ace-jump-mode)
    (define-key wdired-mode-map (kbd "M-o") 'malko/step-out)
    (define-key wdired-mode-map (kbd "C-x C-k") 'dired-do-delete)
    (define-key wdired-mode-map (kbd "M-<up>") 'dired-back-to-top)
    (define-key wdired-mode-map (kbd "M-<down>") 'dired-jump-to-bottom)))

(provide 'setup-dired)
