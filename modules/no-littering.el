;; Keep ~/.emacs.d clean
(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory
	(expand-file-name "etc/" user-emacs-directory)
        no-littering-var-directory
	(expand-file-name "var/" user-emacs-directory))
  :config
  (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t))
        custom-file (no-littering-expand-etc-file-name "custom.el")))
