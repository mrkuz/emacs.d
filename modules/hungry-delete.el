(use-package hungry-delete
  :diminish hungry-delete-mode
  :init
  (global-hungry-delete-mode)
  :config
  (setq hungry-delete-chars-to-skip " "))
