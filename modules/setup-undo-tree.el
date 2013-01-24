;; represent undo-history as an actual tree (visualize with C-x u)
(require 'undo-tree)

(setq undo-tree-mode-lighter "")
(global-undo-tree-mode)

(define-key undo-tree-map (kbd "C-/") nil)
(define-key undo-tree-map (kbd "C-?") nil)

(provide 'setup-undo-tree)
