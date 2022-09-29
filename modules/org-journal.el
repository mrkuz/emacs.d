(use-package org-journal
  :demand t
  :config
  (global-unset-key (kbd "C-c C-j"))
  (setq org-journal-dir (concat org-directory "/journal")
        org-journal-file-type 'weekly
        org-journal-file-format "%Y%m%d_W%V.org"
        org-journal-date-format "%Y-%m-%d, %A"
        org-journal-carryover-items nil))
