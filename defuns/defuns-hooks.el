(add-hook 'find-file-hook (lambda ()
  (if (< (number-of-windows) 2)
    (font-size-big)
    (font-size-normal))))
