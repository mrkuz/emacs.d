;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package org-journal
  :custom
  (org-journal-dir (expand-file-name "journal" org-directory))
  ;; One file per week
  (org-journal-file-type 'weekly)
  ;; ISO week-year (%G), e.g. 2026-W33.org
  (org-journal-file-format "%G-W%V.org")
  ;; Don't carry over unfinished TODOs
  (org-journal-carryover-items nil)
  :config
  ;; Create up front, otherwise org-journal prompts for it
  (make-directory org-journal-dir t))

;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Journal template, invoked via org-protocol:
;;   emacsclient -n -c -F '((name . "org-protocol-capture"))' \
;;               'org-protocol://capture?template=j'
(add-to-list 'org-capture-templates
             '("j" "Journal entry" plain (function my//org-journal-capture-location)
               "** %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-journal-capture-location ()
  "Open this week's journal and move point to the end for `org-capture'."
  (org-journal-new-entry t)
  (goto-char (point-max)))

(defun my/org-open-journal ()
  "Switch to this week's journal file, creating it if necessary."
  (interactive)
  ;; No public accessor for the current journal path
  (let* ((file (org-journal--get-entry-path))
         (buffer (find-buffer-visiting file)))
    (if buffer
        ;; Reuse the window showing it, to keep point and layout
        (pop-to-buffer buffer '((display-buffer-reuse-window
                                 display-buffer-same-window)
                                (reusable-frames . t)))
      ;; Opens and creates if missing; `org-journal-open-current-journal-file'
      ;; only messages when the file is absent
      (org-journal-new-entry t))))
