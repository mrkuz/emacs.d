;; Add filename/olp after agenda element
(defun my//org-ql-view-advice (fun &rest args)
  (if (not args)
      ""
    (let* ((element (car args))
           (properties (cadr element))
           (result (apply fun args))
           ;; Collect properties
           (marker (plist-get properties :org-marker))
           (level (plist-get properties :level))
           (scheduled (plist-get properties :scheduled))
           ;; Format timestamp
           (timestamp (org-element-timestamp-interpreter scheduled 'ignore))
           (time (if (org-timestamp-has-time-p scheduled) (org-format-time-string " @ %H:%M" (org-time-string-to-time timestamp) (current-time-zone)) ""))
           (date (if timestamp (org-format-time-string "%Y-%m-%d, " (org-time-string-to-time timestamp) (current-time-zone)) ""))
           ;; Format file name
           (filename (buffer-file-name (marker-buffer marker)))
           (directory (concat (expand-file-name org-directory) "/"))
           (first (string-remove-prefix directory filename))
           ;; Format outline path
           (rest (when (> level 1)
                   (with-current-buffer (marker-buffer marker)
                     (goto-char marker)
                     (concat ", " (org-no-properties (org-format-outline-path (org-get-outline-path))))))))
      (concat result
              (propertize time 'face 'bold-italic)
              (propertize (concat " (" date first rest ")") 'face 'shadow)))))

(defun my/org-ql-agenda ()
  "Show agenda."
  (interactive)
  (let ((one-week-from-today (format-time-string "%Y-%m-%d" (org-read-date nil t "+8d"))))
    (org-ql-search (org-agenda-files)
      '(and (todo)
            (not (todo "PROJECT"))
            (not (todo "ON_HOLD"))
            (not (todo "DONE"))
            (not (todo "CANCELED")))
      :title "Agenda"
      :super-groups `(
                      (:name "*** Scheduled without timestamp ***\n" :and (:scheduled nil :todo "SCHEDULED"))
                      (:name "Today\n" :and (:scheduled today :not (:todo "WAITING")) :and (:deadline today :not (:todo "WAITING")))
                      (:name "Overdue\n" :and (:scheduled past :not (:todo "EVENT" :todo "WAITING")) :deadline past)
                      (:name "Upcoming\n" :and (:scheduled (before ,one-week-from-today) :not (:todo "WAITING")) :and (:deadline (before ,one-week-from-today) :not (:todo "WAITING")))
                      (:name "Staged\n" :and (:scheduled nil :deadline nil :todo "STAGED"))
                      (:name "Backlog\n" :and (:scheduled nil :deadline nil :todo "TODO"))
                      (:name "Waiting\n" :todo "WAITING")
                      (:name "Journal\n" :todo "OPEN")
                      (:discard (:anything t)))
      :sort 'scheduled)))

(use-package org-ql
  :init
  (advice-add 'org-ql-view--format-element :around 'my//org-ql-view-advice))
