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

;;; javascript
(defun js-method-p ()
  (save-excursion
    (word-search-backward "function")
    (looking-back ": ")))

(defun js-function-declaration-p ()
  (save-excursion
    (word-search-backward "function")
    (looking-back "^\\s *")))

(defun snippet--function-punctuation ()
  (if (js-method-p)
      (when (not (looking-at "[ \n\t\r]*}"))
        (insert ","))
    (unless (js-function-declaration-p)
      (if (looking-at "$") (insert "")))))

(defun snippet--function-name ()
  (if (js-function-declaration-p) "name" ""))

;; snippet-helper-helpers
(defun chop-suffix (suffix s)
  "Remove string 'suffix' if it is at end of string 's'"
  (let ((pos (- (length suffix))))
    (if (and (>= (length s) (length suffix))
             (string= suffix (substring s pos)))
        (substring s 0 pos)
      s)))

(defun chop-prefix (prefix s)
  "Remove string 'prefix' if it is at start of string 's'"
  (let ((pos (length prefix)))
    (if (and (>= (length s) (length prefix))
             (string= prefix (substring s 0 pos)))
        (substring s pos)
      s)))
