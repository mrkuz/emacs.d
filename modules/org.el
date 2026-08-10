;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Base directory for Org files
(setq org-directory "~/org")

;; Keep drawers folded, so TAB reveals the body instead of the properties
(setq org-cycle-hide-drawer-startup t)
(add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

;; Journal template, invoked via org-protocol:
;;   emacsclient -n -c -F '((name . "org-protocol-capture"))' \
;;               'org-protocol://capture?template=j'
(setq org-capture-templates
      '(("j" "Journal entry" plain (function my//org-journal-capture-location)
         "** %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")))

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

;; Needed to answer org-protocol:// URLs
(require 'org-protocol)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-journal-capture-location ()
  "Open this week's journal and move point to the end for `org-capture'."
  (org-journal-new-entry t)
  (goto-char (point-max)))

(defun my/org-open-todo ()
  "Open todo.org in the Org directory."
  (interactive)
  (find-file (expand-file-name "todo.org" org-directory)))

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

(defun my//org-protocol-capture-single-window ()
  "Give the capture buffer the whole dedicated org-protocol frame."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-other-windows)))
(add-hook 'org-capture-mode-hook #'my//org-protocol-capture-single-window)

(defun my//org-protocol-capture-cleanup (&rest _)
  "Delete the dedicated org-protocol capture frame once capture ends."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-frame)))
(add-hook 'org-capture-after-finalize-hook #'my//org-protocol-capture-cleanup)
