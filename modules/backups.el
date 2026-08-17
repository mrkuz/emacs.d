;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Auto-save on focus change
(add-function :after after-focus-change-function 'do-auto-save)

;; Numbered backups, trimmed only by hand from dired
(setq make-backup-files t
      version-control t
      delete-old-versions 'never)

;; Copy rather than rename, so the original keeps its hard links
(setq backup-by-copying t)

;; What `dired-clean-directory' spares
(setq dired-kept-versions 20
      kept-old-versions 20)
