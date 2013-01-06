;;; ibuffer-perspective.el --- Group ibuffer's list by perspective
;;
;; Copyright (C) 2012 William Stucker
;;
;; Author: William Stucker <wstucker@gmail.com>
;; X-URL: http://github.com/wstucker/ibuffer-perspective
;; URL: http://github.com/wstucker/ibuffer-perspective
;; Version: DEV
;; Version 0.1
;; Created 2012-11-17
;; Keywords: ibuffer, workspace, frames, perspective
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.
;;

;;; Commentary:
;;
;; Adds functionality to ibuffer for grouping buffers by their current
;; perspective.  See http://github.com/nex3/perspective-el for information on
;; emacs perspectives.
;;
;; Note: this functionality is extremely limited. It simply categorizes the
;; ibuffer list via perspective. You can not easily change a buffer's
;; perspective via ibuffer mode at this time. Most likely, this program will
;; not be expanded on account of the original author's infrequent use of
;; perspective mode.
;;
;; This was modelled off of ibuffer-vc. See
;; http://github.com/purcell/ibuffer-vc

;;; Code:
(define-ibuffer-filter perspective-filter
    "Ibuffer perspective filter"
  (:description "Ibuffer perspective filter"
                :reader (read-from-minibuffer
                  "Filter by perspective (regexp): "))
  (let* ((curr-perp (gethash qualifier perspectives-hash))
         (buff-list (persp-buffers curr-perp)))
    (if (member buf buff-list) t nil)))

;;;###autoload
(defun ibuffer-perspective-list-generate ()
  "Create a list of all perspectives by name and return in a
filter format that ibuffer understands"
  (if (eq perspectives-hash nil)
      nil
    (let ((names-list  (list)))
      (maphash (lambda (key value)
                 (add-to-list 'names-list
                              (cons key `((perspective-filter . ,key)))))
               perspectives-hash)
      names-list)))

;;;###autoload
(defun ibuffer-perspective-list ()
  "Set the ibuffer filter to use perspectives"
  (interactive)
  (setq ibuffer-filter-groups (ibuffer-perspective-list-generate))
  (ibuffer-update nil t))

(provide 'ibuffer-perspective)

;;; ibuffer-perspective.el ends here
