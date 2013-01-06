(require 'find-file-in-project)

(setq ffip-project-root-function 'eproject-root)
(setq ffip-limit 4096)
(setq ffip-full-paths t)

;; helper methods to create local settings
(defun ffip--create-exclude-find-options (names)
  (mapconcat (lambda (name)
               (concat "-not -regex \".*" name ".*\"")) names " "))

(defun ffip-local-excludes (&rest names)
  "Given a set of names, will exclude results with those names in the path.

Example:
(ffip-local-excludes \"target\" \"overlays\")
"
  (set (make-local-variable 'ffip-find-options)
       (ffip--create-exclude-find-options
         (-distinct (-concat ffip-default-excludes names)))))

(defun ffip-local-patterns (&rest patterns)
  "An exhaustive list of file name patterns to look for.

Example:
(ffip-local-patterns \"*.js\" \"*.jsp\" \"*.css\")
"
  (set (make-local-variable 'ffip-patterns) patterns))

;; function to create new functions that look for a specific pattern
(defun ffip-create-pattern-file-finder (&rest patterns)
  (lexical-let ((patterns patterns))
    (lambda ()
      (interactive)
      (let ((ffip-patterns patterns))
        (find-file-in-project)))))

;; default excludes - override with ffip-local-excludes
(defvar ffip-default-excludes
  '("node_modules" "\.DS_Store" ".*\.log" "target" "overlays" "vendor"))

(setq ffip-find-options
      (ffip--create-exclude-find-options ffip-default-excludes))

(provide 'setup-ffip)
