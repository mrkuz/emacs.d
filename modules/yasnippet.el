;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package yasnippet
  :custom
  (yas-snippet-dirs (list (no-littering-expand-etc-file-name "snippets")))
  :config
  ;; TAB is a conditional binding: it only expands when a snippet matches,
  ;; otherwise it falls through to `org-cycle' and friends
  (yas-global-mode 1))
