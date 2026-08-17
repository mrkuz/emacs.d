;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Written once, when a week's archive file is created
(setq org-archive-file-header-format "#+TITLE: Archive\n")

;; Create up front, like the journal directory
(make-directory (expand-file-name "archive" org-directory) t)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-archive-path (&optional time)
  "Return the archive file for TIME, defaulting to this week."
  (expand-file-name (format-time-string "%G-W%V.org" time)
                    (expand-file-name "archive" org-directory)))

(defun my//org-archive-location (&rest _)
  "Archive into this week's file."
  ;; Computed per call, since the week moves on while Emacs keeps running
  (setq org-archive-location (format "%s::" (my//org-archive-path))))
(advice-add 'org-archive-subtree :before #'my//org-archive-location)

(defun my//org-archive-tidy ()
  "Drop the blank lines org pads archived entries with."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n\n+\\(\\*+[ \t]\\)" nil t)
      (replace-match "\n\\1"))
    (goto-char (point-max))
    (skip-chars-backward "\n")
    (delete-region (min (1+ (point)) (point-max)) (point-max))))
(add-hook 'org-archive-finalize-hook #'my//org-archive-tidy)
