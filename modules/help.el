;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Drop the default arrow, and mark prefixes that lead to further keys
(setq which-key-separator " "
      which-key-prefix-prefix "> ")

(which-key-mode 1)

;; Echo the help text at point, which also reveals Org link targets.
(setopt eldoc-help-at-pt t)
