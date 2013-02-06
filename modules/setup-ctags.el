(require 'etags-select)

(defun build-ctags ()
  (interactive)
  (message "ctags: building")
  (if (boundp 'git-base-path)
    (let ((root git-base-path))
      (shell-command (concat "ctags -e -R --extra=+fq --exclude=.git -f " root "TAGS " root)))
    (visit-project-tags)
    (message "ctags: built")))

(defun visit-project-tags ()
  (interactive)
  (if (boundp 'git-base-path)
    (let ((tags-file (concat git-base-path "TAGS")))
      (visit-tags-table tags-file))))

(defun malko/find-tag ()
  "Find a tag"
  (interactive)
  (if (boundp 'git-base-path)
    (if (file-exists-p (concat git-base-path "TAGS"))
        (progn
          (visit-project-tags)
          (etags-select-find-tag-at-point))
      (build-ctags))))

(defun malko/ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (if (boundp 'git-base-path)
    (if (file-exists-p (concat git-base-path "TAGS"))
      (progn
        (visit-project-tags)
        (tags-completion-table)
        (let (tag-names)
          (mapatoms (lambda (x)
                      (push (prin1-to-string x t) tag-names))
                    tags-completion-table)
             (etags-select-find (ido-completing-read "Tag: " tag-names)))))))

(provide 'setup-ctags)
