;; represent undo-history as an actual tree (visualize with C-x u)
(require 'undo-tree)

(setq undo-tree-mode-lighter "")
(global-undo-tree-mode)

(provide 'setup-undo-tree)
