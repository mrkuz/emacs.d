;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Disable bell
(setq ring-bell-function 'ignore)

;; Ask for y/n instead of yes/no
(setq use-short-answers t)

;; Steady cursor
(blink-cursor-mode 0)

;; One space ends a sentence, which is what `M-a', `M-e' and filling should assume
(setq sentence-end-double-space nil)

;; Only applies where filling happens, `M-q' and the like
(setq-default fill-column 120)

;; Keep long-line files from locking up the display
(global-so-long-mode 1)

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

;; Suspends the frame, which is never what I want
(global-unset-key (kbd "C-z"))

;; Repeat the last key of a sequence without repeating the prefix
(repeat-mode 1)

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
