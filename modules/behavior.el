(use-package hungry-delete
  :diminish hungry-delete-mode
  :init
  (setq hungry-delete-chars-to-skip " ")
  (global-hungry-delete-mode))

(use-package expand-region)

(use-package move-text
  :init
  (move-text-default-bindings))
