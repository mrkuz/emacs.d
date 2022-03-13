(use-package dired
  :straight (:type built-in)
  ;; Reuse buffer
  :bind (:map dired-mode-map ("RET" . dired-find-alternate-file)))
