;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package yasnippet
  :custom
  (yas-snippet-dirs (list (no-littering-expand-etc-file-name "snippets")))
  :config
  ;; TAB is conditional: it only expands on a match, otherwise it falls through
  (yas-global-mode 1))
