(use-package devdocs
  :init
  (add-hook 'nix-ts-mode-hook (lambda () (setq-local devdocs-current-docs '("nix")))))

