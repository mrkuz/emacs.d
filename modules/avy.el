;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package avy
  :custom
  ;; Put the jump character before the target, instead of covering it
  (avy-style 'pre)
  :bind ("C-c g" . avy-goto-char-timer))
