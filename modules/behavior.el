(use-package hungry-delete
  :diminish hungry-delete-mode
  :init
  (global-hungry-delete-mode)
  :config
  (setq hungry-delete-chars-to-skip " "))

(use-package expand-region)

(use-package move-text
  :init
  (move-text-default-bindings))
