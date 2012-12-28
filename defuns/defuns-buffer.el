(require 'imenu)

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (cleanup-buffer-safe)
  (indent-buffer))

(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))

(defun create-scratch-buffer nil
  "create a new scratch buffer to work in."
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)))

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet
      ((addsymbols (symbol-list)
       (when (listp symbol-list)
         (dolist (symbol symbol-list)
           (let ((name nil) (position nil))
             (cond
              ((and (listp symbol) (imenu--subalist-p symbol))
               (addsymbols symbol))

              ((listp symbol)
               (setq name (car symbol))
               (setq position (cdr symbol)))

              ((stringp symbol)
               (setq name symbol)
               (setq position (get-text-property 1 'org-imenu-marker symbol))))

             (unless (or (null position) (null name))
               (add-to-list 'symbol-names name)
               (add-to-list 'name-and-pos (cons name position))))))))
       (addsymbols imenu--index-alist))

    ;; matching symbols at point? put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                 (if (string-match regexp symbol) symbol)) symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names
              (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))

    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark (point))
      (goto-char position))))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun list-existing-buffers ()
  (interactive)
  (ibuffer-list-buffers)
  (other-window 1)
  (delete-other-windows))

(defun turn-off-whitespace ()
  (whitespace-mode nil))

(defun turn-on-whitespace ()
  (whitespace-mode t))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))
