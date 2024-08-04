(use-package org-agenda
  :ensure nil
  :init
  (setq org-agenda-files '("~/org/todo.org" "~/org/roles/" "~/org/projects/" "~/org/calendar/" "~/org/mobile/"))
  :bind (("C-c a" . 'org-agenda)))

