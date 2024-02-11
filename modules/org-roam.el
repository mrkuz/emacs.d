(defun my/search-notes ()
  "Search notes."
  (interactive)
  (consult-ripgrep org-roam-directory))

(use-package org-roam
  :init
  (setq org-roam-directory "~/Notes/")
  (setq org-roam-completion-everywhere t)
  (setq org-roam-completion-functions
        (list (cape-capf-super
               #'org-roam-complete-everywhere
               #'org-roam-complete-link-at-point
               #'cape-dabbrev)))
  ;; Move org-roam buffer to the right side
  (add-to-list 'display-buffer-alist
              '("\\*org-roam\\*"
                (display-buffer-in-direction)
                (direction . right)
                (window-width . 0.30)
                (window-height . fit-window-to-buffer)))
  :config
  (org-roam-db-autosync-mode))
