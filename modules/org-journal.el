;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

;; For `cl-letf' below
(require 'cl-lib)

(use-package org-journal
  ;; `my/org-open-journal' calls into org-journal, which `:hook' would defer
  :demand t
  :hook (org-journal-after-header-create . my//org-journal-open-day)
  :custom
  (org-journal-dir (expand-file-name "journal" org-directory))
  ;; One file per week
  (org-journal-file-type 'weekly)
  ;; ISO week-year (%G), e.g. 2026-W33.org
  (org-journal-file-format "%G-W%V.org")
  ;; e.g. Thursday, 2026-08-13
  (org-journal-date-format "%A, %Y-%m-%d")
  ;; Passed through `format-time-string'; only added to a new file
  (org-journal-file-header "#+TITLE: Weekly Journal (W%V)
* Overview

#+BEGIN: clocktable :scope file :maxlevel 1 :emphasize t
#+END:
")
  ;; Don't carry over unfinished TODOs
  (org-journal-carryover-items nil)
  ;; Use the whole frame; the default splits the window
  (org-journal-find-file-fn 'find-file)
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
               "** %(format-time-string org-journal-time-format)%?\n"))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-journal-keep-folding (orig &rest args)
  "Run ORIG without letting org-journal refold the whole buffer."
  ;; `outline-show-entry' is left alone, so the new entry is still revealed
  (cl-letf (((symbol-function 'outline-hide-sublevels) #'ignore)
            ((symbol-function 'outline-hide-other) #'ignore)
            ((symbol-function 'outline-show-subtree) #'ignore)
            ((symbol-function 'outline-show-all) #'ignore))
    (apply orig args)))
(advice-add 'org-journal-new-entry :around #'my//org-journal-keep-folding)

;; State has to cross hooks: the day is created before its first entry
(defvar my//org-journal-new-day nil
  "Non-nil when the day heading was just created.")

(defun my//org-journal-add-entry (snippet)
  "Add a journal entry and expand SNIPPET into it."
  ;; `org-journal-new-entry' leaves point at the end of the new heading
  (org-journal-new-entry nil)
  (yas-expand-snippet (yas-lookup-snippet snippet 'org-journal-mode)))

(defun my//org-journal-greet ()
  "Expand the greeting into the first entry of a new day."
  (when my//org-journal-new-day
    (setq my//org-journal-new-day nil)
    (yas-expand-snippet (yas-lookup-snippet "hello" 'org-journal-mode))))

(defun my//org-journal-ensure-greeting ()
  "Add the greeting entry when the day heading was just created."
  ;; Every command creating a day must call this, or the flag greets a later entry
  (when my//org-journal-new-day
    (org-journal-new-entry nil)))

(add-hook 'org-journal-after-entry-create-hook #'my//org-journal-greet)

(defun my//org-journal-refresh-overview ()
  "Keep the Overview clocktable current whenever the journal is saved."
  (add-hook 'before-save-hook #'org-update-all-dblocks nil t))
(add-hook 'org-journal-mode-hook #'my//org-journal-refresh-overview)

(defun my//org-journal-open-day ()
  "Mark a newly created journal day as OPEN, clock in and greet."
  ;; Without this the state change is logged, which org-journal's CREATED covers
  (let ((org-inhibit-logging t))
    (org-todo "OPEN"))
  (org-clock-in)
  (setq my//org-journal-new-day t))

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
    ;; A brand new day was already clocked in by `my//org-journal-open-day'
    (unless my//org-journal-new-day
      (org-clock-in)))
  (my//org-journal-ensure-greeting))

(defun my//org-journal-focus-today ()
  "Fold the journal down to today's entries, with the greeting expanded."
  (my//org-journal-goto-today)
  (org-cycle-overview)
  (org-fold-show-children)
  (save-excursion
    ;; The greeting is always the first entry of the day
    (when (org-goto-first-child)
      (org-fold-show-subtree))))

(defun my/org-journal-good-bye ()
  "Add a closing entry to today's journal and clock out."
  (interactive)
  ;; Clock out first, so the CLOCK line is written before the snippet is active.
  ;; Quietly: a stale clock must not stop the entry from being written
  (org-clock-out nil t)
  ;; The clock-out has landed, so the Overview totals are complete
  (org-update-all-dblocks)
  ;; Lay the day out before writing, so the entry stays revealed on top of it
  (my//org-journal-focus-today)
  (my//org-journal-add-entry "bye"))

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
      (org-journal-new-entry t)
      (my//org-journal-ensure-greeting))))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-journal (:color blue :hint nil)
  "
^Journal^
-----------------------
_i_ Clock in
_o_ Clock out
_O_ Good bye!
"
  ("i" my/org-journal-clock-in)
  ("o" org-clock-out)
  ("O" my/org-journal-good-bye)
  ("q" nil))
