;;--------------------------------------------------------------------------------------------------
;; General
;;--------------------------------------------------------------------------------------------------

(defun my/org-find-todo ()
  "Open configuration file."
  (interactive)
  (find-file (concat org-directory "/todo.org")))

(use-package org
  :straight (:type built-in)
  :diminish org-indent-mode
  :init
  (setq org-directory "~/org")
  ;; Open files folded
  (setq org-startup-folded t)
  ;; Allow setting refile targets as local file variable
  (put 'org-refile-targets 'safe-local-variable (lambda (_) t))

  ;; Add tags immediate after the headline
  (setq org-tags-column 0)
  ;; Hide ephasis marker characters
  (setq org-hide-emphasis-markers t)
  ;; Never add blank lines before new entries
  (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

  ;; Indentation
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq org-indent-indentation-per-level 1)
  (diminish 'org-indent-mode)

  ;; Archive
  (setq org-archive-location "~/org/.archive.org::* File: %s")
  ;; Don't add header to archive file
  (setq org-archive-file-header-format nil)

  ;; TODO keywords
  (setq org-todo-keywords '(
                            (sequence "TODO(t)" "NEXT(n)" "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "EVENT(e)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "PROJECT(p)" "|" "ON_HOLD(h!)")))
  ;; Insert log notes into LOGBOOK
  (setq org-log-into-drawer t)

  ;; Agenda
  (setq org-agenda-files '("~/org/todo.org" "~/org/projects/" "~/org/calendar/" "~/org/journal/" "~/org/mobile/"))
  ;; Capture
  (setq org-capture-templates '(
                                ("b" "New backlog entry" entry (file+olp "todo.org" "Backlog")
                                 "* %?\nCREATED: %U" :prepend t)
                                ("w" "Capture web page" entry (file "capture.org")
                                 "* %?\nCREATED: %U\nTITLE: %:description%\nURL: %:link\n\n%i" :prepend t)
                                ("p" "Capture primary selection" entry (file "capture.org")
                                 "* %?\nCREATED: %U\n\n%(gui-get-primary-selection)" :prepend t)
                                ))
  :bind (("C-c l" . 'org-store-link)
         ("C-c a" . 'org-agenda)
         ("C-c c" . 'org-capture))
  :hook (org-mode . org-indent-mode))

;;--------------------------------------------------------------------------------------------------
;; org-protocol
;;--------------------------------------------------------------------------------------------------

(require 'org-protocol)

;; Make capture window the only one
(defun my/org-protocol-capture-hook ()
  (let ((name (cdr (assoc 'name (frame-parameters)))))
    (when (equal name "org-protocol-capture")
      (delete-other-windows)
      (modify-frame-parameters nil '((z-group . above)))
      (select-frame-set-input-focus (selected-frame)))))

(add-hook 'org-capture-mode-hook 'my/org-protocol-capture-hook)

;; Delete frame after done
(defun my/org-protocol-after-capture-hook ()
  (let ((name (cdr (assoc 'name (frame-parameters)))))
    (when (equal name "org-protocol-capture")
      (delete-frame))))

(add-hook 'org-capture-after-finalize-hook 'my/org-protocol-after-capture-hook)

;;--------------------------------------------------------------------------------------------------
;; org-bullets
;;--------------------------------------------------------------------------------------------------

(use-package org-bullets
  :init
  (setq org-bullets-bullet-list '("◉" "○" "●" "◦" "•"))
  :hook (org-mode . org-bullets-mode))

;;--------------------------------------------------------------------------------------------------
;; org-ql
;;--------------------------------------------------------------------------------------------------

;; Add filename after agenda element
(defun my/org-ql-view-advice (fun &rest args)
  (if (not args)
      ""
    (let* ((element args)
           (properties (cadar element))
           (result (apply fun element))
           (filename (buffer-file-name (marker-buffer (plist-get properties :org-marker))))
           (name (downcase (string-remove-suffix ".org"
                            (string-remove-prefix (concat (expand-file-name org-directory) "/") filename)))))
      (concat result " [" name "]"))))

(use-package org-ql
  :init
  (advice-add 'org-ql-view--format-element :around 'my/org-ql-view-advice)
  (setq org-agenda-custom-commands
        '(("o" "Overview"
           ((org-ql-block '(and (todo "NEXT" "EVENT") (scheduled :on today)) ((org-ql-block-header "Today")) )
            (org-ql-block '(and (todo "NEXT") (scheduled :to -1)) ((org-ql-block-header "Missed")))
            (org-ql-block '(and (todo "NEXT" "EVENT") (scheduled :from 1 :to 7)) ((org-ql-block-header "Upcoming")))
            (org-ql-block '(and (todo "NEXT") (not (scheduled))) ((org-ql-block-header "Next")))
            (org-ql-block '(and (todo "TODO") (not (scheduled))) ((org-ql-block-header "Backlog")))
            )))))

;;--------------------------------------------------------------------------------------------------
;; org-roam
;;--------------------------------------------------------------------------------------------------

(use-package org-roam
  :init
  (setq org-roam-v2-ack t
        org-roam-directory "~/org/notes/"
        ;; Enable completion of note links
        org-roam-completion-everywhere t)
  ;; Move org-roam boffer to the right side
  (add-to-list 'display-buffer-alist
              '("\\*org-roam\\*"
                (display-buffer-in-direction)
                (direction . right)
                (window-width . 0.30)
                (window-height . fit-window-to-buffer)))
  :config
  (org-roam-db-autosync-mode))
