;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------
 
;; Auto-save on focus change
(add-function :after after-focus-change-function 'do-auto-save)

;; Disable backup files
(setq make-backup-files nil)
