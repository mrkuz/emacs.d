;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Allows refiling to headings at all levels
(setq org-refile-targets '((nil :maxlevel . 99)))

;; Offers the full path as a single candidate
(setq org-refile-use-outline-path t
      org-outline-path-complete-in-steps nil)
