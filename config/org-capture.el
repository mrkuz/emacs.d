(use-package org-capture
  :ensure nil
  :init
  (setq org-capture-templates '(("b" "Backlog entry" entry (file+olp "todo.org" "Backlog")
                                 "** %?\n:LOGBOOK:\n- State \"CREATED\"                      %U\n:END:\n%i" :prepend t)
                                ))
  :bind (("C-c c" . 'org-capture)))

