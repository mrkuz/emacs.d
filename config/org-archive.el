(defun my//get-archive-location ()
  (concat "~/org/archive/" (format-time-string "%Y_W%V.org" (current-time)) "::* File: %s"))

(use-package org-archive
  :elpaca nil
  :init
  (setq org-archive-location (my//get-archive-location))
  ;; Don't add header to archive file
  (setq org-archive-file-header-format nil))

