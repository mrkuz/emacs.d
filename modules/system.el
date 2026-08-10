;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Disable bell
(setq ring-bell-function 'ignore)

;; Ask for y/n instead of yes/no
(setq use-short-answers t)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/byte-compile-config ()
  "Byte-compile the configuration files to surface warnings."
  (interactive)
  ;; Modules are loaded from source; the .elc files are only for the warnings
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
