;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Reuse the buffer instead of opening one per directory
(put 'dired-find-alternate-file 'disabled nil)

;; Deletions go to the trash, recoverable
(setq delete-by-moving-to-trash t)

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
