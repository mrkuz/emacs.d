;; Show diff with 'd' and timestamps with 't'
(use-package undo-tree
  :diminish undo-tree-mode
  :init
  ;; Inhibit keymap setup
  (setq undo-tree-map (make-sparse-keymap))
  ;; Don't save history
  (setq undo-tree-auto-save-history nil)
  ;; Show times
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-relative-timestamps nil)
  (setq undo-tree-visualizer-diff t)
  :hook ((text-mode . undo-tree-mode)
         (prog-mode . undo-tree-mode)))
