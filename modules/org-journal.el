(defun my//org-journal-file-header-func (time)
  (concat
   "#+TITLE: Weekly Journal"
   (format-time-string " (W%V)" time)))

(use-package org-journal
  :demand t
  :config
  (global-unset-key (kbd "C-c C-j"))
  (setq org-journal-dir (concat org-directory "/journal")
        org-journal-file-type 'weekly
        org-journal-file-format "%Y%m%d_W%V.org"
        org-journal-file-header 'my//org-journal-file-header-func
        org-journal-date-format "OPEN %Y-%m-%d, %A"
        org-journal-carryover-items nil))
