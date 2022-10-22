(defun my/org-find-todo ()
  "Open configuration file."
  (interactive)
  (find-file (concat org-directory "/todo.org")))

(defun my/org-schedule ()
  "Schedule a task."
  (interactive)
  (org-schedule t)
  (org-todo "SCHEDULED"))

;; As for timestamp for SCHEDULED and EVENT items
(defun my//org-trigger-hook (args)
  (setq new-state (plist-get args :to))
  (when (or (string-equal new-state "SCHEDULED")
            (string-equal new-state "EVENT"))
    (run-with-timer 0 nil (lambda () (org-schedule t)))))
(add-hook 'org-trigger-hook 'my//org-trigger-hook)

(defun my//org-find-journal-location ()
  (org-journal-new-entry t)
  (goto-char (point-max)))

(use-package org
  :straight (:type built-in)
  :diminish org-indent-mode
  :init
  (setq org-directory "~/org")
  ;; Open files with two levels open
  (setq org-startup-folded 'show2levels)
  ;; Allow setting refile targets as local file variable
  (put 'org-refile-targets 'safe-local-variable (lambda (_) t))

  ;; Add tags immediate after the headline
  (setq org-tags-column 0)
  ;; Hide ephasis marker characters
  (setq org-hide-emphasis-markers t)
  ;; Never add blank lines before new entries
  (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

  ;; Stop after TODO keyword and before tags on first C-a/C-e
  (setq org-special-ctrl-a/e t)

  ;; Indentation
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq org-indent-indentation-per-level 1)
  (diminish 'org-indent-mode)

  ;; Don't auto-indent source
  (setq org-src-preserve-indentation t)

  ;; Archive
  (setq org-archive-location "~/org/.archive.org::* File: %s")
  ;; Don't add header to archive file
  (setq org-archive-file-header-format nil)

  ;; TODO keywords
  (setq org-todo-keywords '(
                            (sequence "TODO(t!)" "STAGED(.!)" "SCHEDULED(:!)" "NEXT(n!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "EVENT(e!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "OPEN(o!)""ON_HOLD(h!) | DONE(d!)" "CANCELED(c!)")
                            (sequence "PROJECT(p!)""ON_HOLD(h!) | DONE(d!)" "CANCELED(c!)")))
  ;; Insert log notes into LOGBOOK
  (setq org-log-into-drawer t)

  ;; Don't ask for confirmation on evaluate
  (setq org-confirm-babel-evaluate nil)
  ;; Load language support
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (shell . t)))

  ;; Agenda
  (setq org-agenda-files '("~/org/todo.org" "~/org/roles/" "~/org/projects/" "~/org/calendar/" "~/org/journal/" "~/org/mobile/"))
  ;; Capture
  (setq org-capture-templates '(
                                ("j" "Journal entry" plain (function my//org-find-journal-location)
                                 "** %(format-time-string org-journal-time-format)%?\n%i")
                                ("b" "New backlog entry" entry (file+olp "todo.org" "Backlog")
                                 "* %?\nCREATED: %U" :prepend t)
                                ("w" "Capture web page" entry (file "capture.org")
                                 "* %?\nCREATED: %U\nTITLE: %:description%\nURL: %:link\n\n%i" :prepend t)
                                ("p" "Capture primary selection" entry (file "capture.org")
                                 "* %?\nCREATED: %U\n\n%(gui-get-primary-selection)" :prepend t)
                                ))
  :config
  ;; Customize ellipsis
  (setq org-ellipsis " …")
  (set-face-attribute 'org-ellipsis nil :underline nil)
  :bind (("C-c l" . 'org-store-link)
         ("C-c a" . 'org-agenda)
         ("C-c c" . 'org-capture)
         :map org-mode-map
         ("C-c C-s" . 'my/org-schedule))
  :hook (org-mode . org-indent-mode))
