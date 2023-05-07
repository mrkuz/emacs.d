;; Disable backup files
;; (setq make-backup-files nil)
;; Make backups also for files under VC
(setq vc-make-backup-files t)
;; Make numeric backups
(setq version-control t)
;; Keep all backups
(setq delete-old-versions -1)
;; Disable auto save
;; (setq auto-save-default nil)

;; https://github.com/emacscollective/no-littering

;; Collect backup files in one directory
(setq backup-directory-alist
      `(("\\`/tmp/" . nil)
        ("\\`/dev/shm/" . nil)
        ("." . ,(no-littering-expand-var-file-name "backup/"))))
;; Collect auto-save files in one directory
(setq auto-save-file-name-transforms
      `(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'"
         ,(concat temporary-file-directory "\\2") t)
        ("\\`\\(/tmp\\|/dev/shm\\)\\([^/]*/\\)*\\(.*\\)\\'" "\\3")
        (".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
