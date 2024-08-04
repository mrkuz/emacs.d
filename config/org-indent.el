(use-package org-indent
  :ensure nil
  :diminish org-indent-mode
  :init
  ;; Indentation
  (setq org-indent-indentation-per-level 1)
  :hook (org-mode . org-indent-mode))
