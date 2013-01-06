(defmacro project-specifics (name &rest body)
  (declare (indent 1))
  `(progn
     (add-hook 'find-file-hook
               (lambda ()
                 (when (string-match-p ,name (buffer-file-name))
                   ,@body)))
     (add-hook 'dired-after-readin-hook
               (lambda ()
                 (when (string-match-p ,name (dired-current-directory))
                   ,@body)))))

;; emacs
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (find-file "~/.emacs.d/init.el")))

(project-specifics ".emacs.d"
  (set (make-local-variable 'git-base-path)
    "~/.emacs.d/")
  (ffip-local-patterns "*.el" "*.md"))

;; instajams
(defun custom-persp/instajams ()
  (interactive)
  (custom-persp "instajams"
                (find-file "~/projects/js/jam_mode/")))

(project-specifics "projects/js/jam_mode"
  (set (make-local-variable 'git-base-path)
    "~/projects/js/jam_mode/")
  (ffip-local-excludes
    "public/apps/.*/js/libs"
    "public/apps/.*/js/specs/libs")
  (ffip-local-patterns "*.js" "*.css" "*.styl"))

;; project switcher
(defvar project-switcher-list
  '("emacs" "instajams"))

(defun project-switcher ()
  (interactive)
  (apply
    (intern (concat "custom-persp/"
              (ido-completing-read "Project name: " project-switcher-list)))
    '()))
