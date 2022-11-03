(use-package benchmark-init
  :demand t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
