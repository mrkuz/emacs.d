;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package no-littering
  :demand t
  :custom
  (no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory))
  (no-littering-var-directory (expand-file-name "var/" user-emacs-directory))
  (custom-file (no-littering-expand-etc-file-name "custom.el"))
  :config
  ;; Store backup and auto-save files in 'var'
  (no-littering-theme-backups)
  ;; Ignore in recentf
  (require 'recentf)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory)))

(use-package exec-path-from-shell
  :demand t
  :config
  (exec-path-from-shell-initialize))

;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Disable bell
(setq ring-bell-function 'ignore)
