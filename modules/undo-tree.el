(use-package undo-tree
  :diminish undo-tree-mode
  :init
  ;; Inhibit keymap setup
  (setq undo-tree-map (make-sparse-keymap))
  (setq undo-tree-auto-save-history nil)
  (setq undo-tree-visualizer-diff nil ; Show diff with 'd'
        undo-tree-visualizer-timestamps t ; Show timestamps with 't'
        undo-tree-visualizer-relative-timestamps nil)
  :hook ((text-mode . undo-tree-mode)
         (prog-mode . undo-tree-mode)))
