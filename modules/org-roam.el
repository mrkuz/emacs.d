(defun my/search-notes ()
  "Search notes."
  (interactive)
  (consult-ripgrep org-roam-directory))

(use-package emacsql-sqlite3)

(use-package org-roam
  :init
  (setq org-roam-v2-ack t
        ;; Use sqlite3 instead of emacs-sqlite
        org-roam-database-connector 'sqlite3
        org-roam-directory "~/Notes/"
        ;; Enable completion of note links
        org-roam-completion-everywhere t)
  ;; Move org-roam buffer to the right side
  (add-to-list 'display-buffer-alist
              '("\\*org-roam\\*"
                (display-buffer-in-direction)
                (direction . right)
                (window-width . 0.30)
                (window-height . fit-window-to-buffer)))
  :config
  (org-roam-db-autosync-mode))
