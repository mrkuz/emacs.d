(use-package dired
  :ensure nil
  ;; Reuse buffer when opening files
  :bind (:map dired-mode-map ("RET" . dired-find-alternate-file)))
