(use-package no-littering
  :demand t
  :config
  (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
        no-littering-var-directory (expand-file-name "var/" user-emacs-directory))
  ;; Store backup and auto-save files in 'var'
  (no-littering-theme-backups)
  (setq custom-file (no-littering-expand-etc-file-name "custom.el")))
