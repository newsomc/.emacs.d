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
                (find-file "~/.emacs.d/")))

(project-specifics ".emacs.d"
  (bvarp 'git-base-path "~/.emacs.d/")

  (ffip-local-patterns "*.el" "*.md"))

;; instajams
(defun custom-persp/instajams ()
  (interactive)
  (custom-persp "instajams"
                (find-file "~/projects/js/jam_mode/")))

;; (put 'magit--bisect-info 'permanent-local t)
(project-specifics "projects/js/jam_mode"
  (bvarp 'git-base-path "~/projects/js/jam_mode/")
  (bvarp 'jump-from-test--pattern
    '("public/apps/\\1/js/specs/\\2/\\3.spec.js" .
      "public/apps/\\1/js/\\2/\\3.js"))
  (bvarp 'jump-to-test--pattern
    '("public/apps/\\1/js/\\2/\\3.js" .
      "public/apps/\\1/js/specs/\\2/\\3.spec.js"))

  (ffip-local-excludes
    "public/apps/.*/js/libs"
    "public/apps/.*/js/specs/libs")
  (ffip-local-patterns "*.js" "*.css" "*.styl" "*.jade"))

;; proglang-2012-001
(defun custom-persp/proglang-2012-001 ()
  (interactive)
  (custom-persp "proglang-2012-001"
                (find-file "~/projects/courses/proglang-2012-001/")))

(project-specifics "projects/courses/proglang-2012-001"
  (bvarp 'git-base-path "~/projects/courses/proglang-2012-001/")

  (ffip-local-patterns "*.sml"))

;; project switcher
(defvar project-switcher-list
  '("emacs" "instajams" "proglang-2012-001"))

(defun project-switcher ()
  (interactive)
  (apply
    (intern (concat "custom-persp/"
              (ido-completing-read "Project name: " project-switcher-list)))
    '()))
