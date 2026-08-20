;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package avy
  :custom
  ;; Puts the jump character before the target
  (avy-style 'pre)
  :bind ("C-c g" . avy-goto-char-timer))
