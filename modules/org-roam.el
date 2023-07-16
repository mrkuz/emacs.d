(defun my/search-notes ()
  "Search notes."
  (interactive)
  (consult-ripgrep org-roam-directory))

(use-package emacsql-sqlite-builtin)

(use-package org-roam
  :init
  (setq org-roam-v2-ack t
        org-roam-database-connector 'sqlite-builtin
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
