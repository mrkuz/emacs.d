(use-package org-bullets
  :init
  (setq org-bullets-bullet-list '("◉" "○" "●" "◦" "•"))
  :hook (org-mode . org-bullets-mode))
