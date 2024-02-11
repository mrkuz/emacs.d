(use-package recentf
  :elpaca nil
  :init
  (recentf-mode)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG")
  (add-to-list 'recentf-exclude ".*-autoloads\\.el"))
