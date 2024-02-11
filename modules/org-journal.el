(defun my//org-journal-file-header-func (time)
  (concat
   "#+TITLE: Weekly Journal"
   (format-time-string " (W%V)" time)))

(defun my//org-find-journal-location ()
  (org-journal-new-entry t)
  (goto-char (point-max)))

(defun my/open-journal-file ()
  "Open current journal file"
  (interactive)
  (org-journal-new-entry t)
  (my/org-focus))

(use-package org-journal
  :init
  (global-unset-key (kbd "C-c C-j"))
  (setq org-journal-dir (concat org-directory "/journal")
        org-journal-file-type 'weekly
        org-journal-file-format "%Y%m%d_W%V.org"
        org-journal-file-header 'my//org-journal-file-header-func
        org-journal-date-format "OPEN %Y-%m-%d, %A"
        org-journal-carryover-items nil)
  :config
  ;; Create journal file if not exists to make org-agenda happy
  (let ((journal-file (org-journal--get-entry-path)))
    (when (not (file-exists-p journal-file))
      (make-empty-file journal-file))
    (add-to-list 'org-agenda-files journal-file t))
  ;; Capture
  (add-to-list 'org-capture-templates '("j" "Journal entry" plain (function my//org-find-journal-location)
                                        "** %(format-time-string org-journal-time-format)%?\n%i")))
