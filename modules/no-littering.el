(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory
    (expand-file-name "etc/" user-emacs-directory)
        no-littering-var-directory
    (expand-file-name "var/" user-emacs-directory))
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el")))
