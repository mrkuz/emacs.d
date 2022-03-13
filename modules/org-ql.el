;; Add filename/olp after agenda element
(defun my/org-ql-view-advice (fun &rest args)
  (if (not args)
      ""
    (let* ((element (car args))
           (properties (cadr element))
           (result (apply fun args))
           (marker (plist-get properties :org-marker))
           (level (plist-get properties :level))
           (filename (buffer-file-name (marker-buffer marker)))
           (directory (concat (expand-file-name org-directory) "/"))
           (first (string-remove-prefix directory filename))
           (rest (when (> level 1)
                   (with-current-buffer (marker-buffer marker)
                     (goto-char marker)
                     (concat ", " (org-no-properties (org-format-outline-path (org-get-outline-path))))))))
      (concat result (propertize (concat " (" first rest ")") 'face 'shadow)))))

(use-package org-ql
  :init
  (advice-add 'org-ql-view--format-element :around 'my/org-ql-view-advice)
  (setq org-agenda-custom-commands
        '(("o" "Overview"
           ((org-ql-block '(or (scheduled :on today)
                               (todo "NEXT"))
                          ((org-ql-block-header "Today")))
            (org-ql-block '(and
                            (not (todo "DONE" "CANCELED"))
                            (scheduled :to -1))
                          ((org-ql-block-header "Overdue")))
            (org-ql-block '(and (todo "TODO") (not (scheduled))) ((org-ql-block-header "Staged")))
            (org-ql-block '(todo "WAITING") ((org-ql-block-header "Waiting")))
            (org-ql-block '(scheduled :from 1 :to 7) ((org-ql-block-header "Upcoming")))
            )))))
