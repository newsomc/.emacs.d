;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

(defun jf/jump-insert-matches (spec matches)
  (if matches
      (let ((count 1) (new-spec spec) (spec nil))
        (while (not (equal spec new-spec))
          (setf spec new-spec)
          (setf new-spec
                (replace-regexp-in-string (format "\\\\%d" count)
                                          (or (nth (- count 1) matches) ".*?")
                                          spec))
          (setf count (+ 1 count)))
        new-spec) spec))

(defun jf/jump-to (spec &optional matches make)
  (if (eq nil matches)
      (message "error: no pattern found for current file")
    (if (eq nil git-base-path)
        (message "error: make sure git-base-path is set to project root")
      (let (
            (f (concat git-base-path (jf/jump-insert-matches spec matches))))
        (if (file-exists-p f)
            (find-file f)
          (progn
            (message "error: jump-to file doesn't exist")))))))

(defun jf/jump-from (spec)
  (cond ((stringp spec)
         (let* ((path (or (and (buffer-file-name)
                               (expand-file-name (buffer-file-name)))
                          (buffer-name))))
           (and (string-match spec path)
                (or (let ((counter 1) mymatch matches)
                      (while (setf mymatch (match-string counter path))
                        (setf matches (cons mymatch matches))
                        (setf counter (+ 1 counter)))
                      (reverse matches)) t))))
        (t (message (format "unrecognized jump-from format %s" spec)))))

(defun jf/format-spec-string (spec)
  (cons (replace-regexp-in-string
         "\\\\[[:digit:]]+" "\\\\(.*?\\\\)"
         (car spec)) (cdr spec)))

(defun jf/jump-to-match (spec)
  (let ((spec (jf/format-spec-string spec)))
    (jf/jump-to (cdr spec) (jf/jump-from (car spec)))))

(provide 'jump-to-other-file)
