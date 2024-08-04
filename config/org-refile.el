(use-package org-refile
  :ensure nil
  :init
  ;; Allow setting refile targets as local file variable
  (put 'org-refile-targets 'safe-local-variable (lambda (_) t))
  (setq org-refile-targets '((nil :maxlevel . 99)))
  ;; Use full path for refile
  (setq org-refile-use-outline-path t)
  ;; Show full path in completion
  (setq org-outline-path-complete-in-steps nil))
