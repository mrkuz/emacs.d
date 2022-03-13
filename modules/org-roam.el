(use-package org-roam
  :init
  (setq org-roam-v2-ack t
        org-roam-directory "~/org/notes/"
        ;; Enable completion of note links
        org-roam-completion-everywhere t)
  ;; Move org-roam boffer to the right side
  (add-to-list 'display-buffer-alist
              '("\\*org-roam\\*"
                (display-buffer-in-direction)
                (direction . right)
                (window-width . 0.30)
                (window-height . fit-window-to-buffer)))
  :config
  (org-roam-db-autosync-mode))
