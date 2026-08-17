;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-agenda-files ()
  "Return todo.org plus this week's and last week's journal."
  ;; No public accessor for a journal path
  (seq-filter #'file-exists-p
              (list (expand-file-name "todo.org" org-directory)
                    (org-journal--get-entry-path)
                    (org-journal--get-entry-path
                     (time-subtract (current-time) (days-to-time 7))))))

(defun my//org-agenda-refresh-files (&rest _)
  "Recompute `org-agenda-files', since the journal files shift every week."
  (setq org-agenda-files (my//org-agenda-files)))
(advice-add 'org-agenda :before #'my//org-agenda-refresh-files)

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(global-set-key (kbd "C-c a") 'org-agenda)
