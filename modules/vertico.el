;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package vertico
  :custom
  (vertico-count completions-max-height)
  ;; Wrap around at either end
  (vertico-cycle t)
  :config
  (vertico-mode 1))

;; Ships with vertico, so nothing to install
(use-package vertico-directory
  :ensure nil
  :after vertico
  ;; Shorten shadowed paths, as when a second `~' or `/' is typed
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :bind (:map vertico-map
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)))
