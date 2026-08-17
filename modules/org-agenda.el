;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; The `!' cookies log state changes, not CLOSED timestamps
(setq org-agenda-log-mode-items '(closed clock state))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-agenda-files ()
  "Return todo.org plus this week's and last week's journal and archive."
  (let ((last-week (time-subtract (current-time) (days-to-time 7))))
    ;; No public accessor for a journal path
    (seq-filter #'file-exists-p
                (list (expand-file-name "todo.org" org-directory)
                      (org-journal--get-entry-path)
                      (org-journal--get-entry-path last-week)
                      (my//org-archive-path)
                      (my//org-archive-path last-week)))))

(defun my//org-agenda-refresh-files (&rest _)
  "Recompute `org-agenda-files', since the journal files shift every week."
  (setq org-agenda-files (my//org-agenda-files)))
(advice-add 'org-agenda :before #'my//org-agenda-refresh-files)
(advice-add 'org-agenda-list :before #'my//org-agenda-refresh-files)

(defun my/org-agenda-week ()
  "Show the agenda for this week."
  (interactive)
  (org-agenda-list nil nil 'week))

(defun my/org-agenda-log-today ()
  "Show what was closed, clocked and changed state today."
  (interactive)
  ;; `only' hides scheduled and deadline entries
  (let ((org-agenda-start-with-log-mode 'only))
    (org-agenda-list nil nil 'day)))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(global-set-key (kbd "C-c a") 'org-agenda)
