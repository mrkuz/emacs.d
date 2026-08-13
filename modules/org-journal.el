;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

;; For `cl-letf' below
(require 'cl-lib)

(use-package org-journal
  ;; `my/org-open-journal' calls into org-journal, which `:hook' would defer
  :demand t
  :hook ((org-journal-after-entry-create . my/org-set-added)
         (org-journal-after-header-create . my//org-journal-open-day))
  :custom
  (org-journal-dir (expand-file-name "journal" org-directory))
  ;; One file per week
  (org-journal-file-type 'weekly)
  ;; ISO week-year (%G), e.g. 2026-W33.org
  (org-journal-file-format "%G-W%V.org")
  ;; e.g. Thursday, 2026-08-13
  (org-journal-date-format "%A, %Y-%m-%d")
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
               "** %(format-time-string org-journal-time-format)%?\n:PROPERTIES:\n:ADDED: %U\n:END:\n"))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-journal-keep-folding (orig &rest args)
  "Run ORIG without letting org-journal refold the whole buffer.
`outline-show-entry' is left alone, so the new entry is still revealed."
  (cl-letf (((symbol-function 'outline-hide-sublevels) #'ignore)
            ((symbol-function 'outline-hide-other) #'ignore)
            ((symbol-function 'outline-show-subtree) #'ignore)
            ((symbol-function 'outline-show-all) #'ignore))
    (apply orig args)))
(advice-add 'org-journal-new-entry :around #'my//org-journal-keep-folding)

(defun my//org-journal-open-day ()
  "Mark a newly created journal day as OPEN and start its clock."
  ;; Without this the state change is logged, which org-journal's CREATED covers
  (let ((org-inhibit-logging t))
    (org-todo "OPEN"))
  (org-clock-in))

(defun my//org-journal-goto-today ()
  "Move point to today's day heading, creating the day if necessary."
  (org-journal-new-entry t)
  (org-back-to-heading t)
  ;; Entries are level 2; the day is their parent
  (while (> (org-outline-level) 1)
    (org-up-heading-safe)))

(defun my/org-journal-clock-in ()
  "Clock in on today's journal day."
  (interactive)
  (save-window-excursion
    (my//org-journal-goto-today)
    (org-clock-in)))

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

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-journal (:color blue :hint nil)
  "
^Journal^
-----------------------
_i_ Clock in
_o_ Clock out
"
  ("i" my/org-journal-clock-in)
  ("o" org-clock-out)
  ("q" nil))
