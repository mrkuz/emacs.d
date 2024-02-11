(use-package dumb-jump
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  ;; Use completion-read to select target
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read))
