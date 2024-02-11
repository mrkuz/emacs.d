(use-package hungry-delete
  :diminish hungry-delete-mode
  :init
  (global-hungry-delete-mode)
  ;; Limit hungry delete to space character
  (setq hungry-delete-chars-to-skip " "))
