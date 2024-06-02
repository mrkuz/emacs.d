;; Force backup on each save
(defun my//force-backup-buffer ()
  (if buffer-backed-up
    (let ((buffer-backed-up nil))
      (backup-buffer))))
(add-hook 'before-save-hook 'my//force-backup-buffer)

;; Disable backup files
;; (setq make-backup-files nil)
;; Make backups also for files under VC
(setq vc-make-backup-files t)
;; Make numeric backups
(setq version-control t)
;; Keep all backups
(setq delete-old-versions -1)
;; Always create backup by copying file
(setq backup-by-copying t)

;; Disable auto save
;; (setq auto-save-default nil)
;; Auto-save on focus change
(add-function :after after-focus-change-function 'do-auto-save)
