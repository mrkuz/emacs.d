(use-package dired
  :elpaca nil
  ;; Reuse buffer when opening files
  :bind (:map dired-mode-map ("RET" . dired-find-alternate-file)))
