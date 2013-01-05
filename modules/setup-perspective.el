(require 'perspective)

(persp-mode t)

(defmacro custom-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash)))
         (current-perspective persp-curr))
     (persp-switch ,name)
     (when initialize ,@body)
     (setq persp-last current-perspective)))

(defun custom-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

(provide 'setup-perspective)
