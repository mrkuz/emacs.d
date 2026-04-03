;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Store autosave files in var/autosave/
(setq my//autosave-dir (expand-file-name "var/autosave/" user-emacs-directory))
(make-directory my//autosave-dir t)
(setq auto-save-file-name-transforms `((".*" ,my//autosave-dir t)))

;; Auto-save on focus change
(add-function :after after-focus-change-function 'do-auto-save)

;; Disable backup files
(setq make-backup-files nil)
