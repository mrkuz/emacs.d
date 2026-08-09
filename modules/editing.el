;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package expand-region)

(use-package crux
  :config
  ;; If no region is selected, use whole buffer
  (crux-with-region-or-buffer untabify))
