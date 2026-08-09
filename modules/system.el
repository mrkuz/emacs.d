;; -*- lexical-binding: t; -*-
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
               (recentf-expand-file-name no-littering-etc-directory))
  ;; Load customizations written by `customize'
  (load custom-file 'noerror 'nomessage))

(use-package exec-path-from-shell
  :demand t
  :config
  (exec-path-from-shell-initialize))

;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Disable bell
(setq ring-bell-function 'ignore)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/byte-compile-config ()
  "Byte-compile the configuration files to surface warnings."
  (interactive)
  ;; Modules are loaded from source, so the .elc files are only a means to get
  ;; the compiler's warnings; delete them afterwards.
  (let ((files (cons early-init-file
                     (cons user-init-file
                           (directory-files
                            (expand-file-name "modules" user-emacs-directory)
                            t "\\.el\\'")))))
    (dolist (file files)
      (byte-compile-file file)
      (let ((elc (byte-compile-dest-file file)))
        (when (and elc (file-exists-p elc))
          (delete-file elc))))
    (message "Configuration byte-compiled; see *Compile-Log*")))
