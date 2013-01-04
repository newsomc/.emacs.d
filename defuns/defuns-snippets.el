;; create new snippet
(defun yas-create-new-snippet (&optional no-template)
  (interactive "P")
  (let ((guessed-directories (yas--guess-snippet-directories)))
    (switch-to-buffer "*new snippet*")
    (erase-buffer)
    (kill-all-local-variables)
    (snippet-mode)
    (yas-minor-mode 1)
    (set (make-local-variable 'yas--guessed-modes)
      (mapcar #'(lambda (d)
                  (yas--table-mode (car d)))
              guessed-directories))
    (yas-expand-snippet "\
# -*- mode: snippet -*-
# name: $1
# key: ${2:${1:$(replace-regexp-in-string \"\\\\\\\\(\\\\\\\\w+\\\\\\\\).*\" \"\\\\\\\\1\" yas-text)}}
# --
$0")))
