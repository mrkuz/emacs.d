(defun my/org-find-todo ()
  "Open configuration file."
  (interactive)
  (find-file (concat org-directory "/todo.org")))

(defun my/org-focus ()
  "Focus on current header."
  (interactive)
  (org-overview)
  (outline-back-to-heading)
  (org-show-children))

;; As for timestamp for SCHEDULED and EVENT items
(defun my//org-trigger-hook (args)
  (setq new-state (plist-get args :to))
  (when (or (string-equal new-state "SCHEDULED")
            (string-equal new-state "EVENT"))
    (run-with-timer 0 nil (lambda () (org-schedule t))))
  (when (string-equal new-state "STAGED")
    (run-with-timer 0 nil (lambda () (org-deadline t)))))
(add-hook 'org-trigger-hook 'my//org-trigger-hook)

(defun my//org-find-journal-location ()
  (org-journal-new-entry t)
  (goto-char (point-max)))

(defun my//get-primary-selection ()
  (ignore-errors (gui-get-primary-selection)))

(defun my//get-archive-location ()
  (concat "~/org/archive/" (format-time-string "%Y_W%V.org" (current-time)) "::* File: %s"))

(use-package org
  :straight (:type built-in)
  :diminish org-indent-mode
  :init
  (require 'org-mouse)
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
  (setq org-archive-location (my//get-archive-location))
  ;; Don't add header to archive file
  (setq org-archive-file-header-format nil)

  ;; TODO keywords
  (setq org-todo-keywords '(
                            (sequence "TODO(t!)" "SCHEDULED(.!)" "STAGED(:!)" "WAITING(w!)" "|" "DONE(d!)")
                            (sequence "EVENT(e!)" "|" "CANCELED(c!)")
                            (sequence "OPEN(o!)" "|" "DONE(d!)")
                            (sequence "REMINDER(r!)" "|" "DONE(d!)")
                            (sequence "PROJECT(p!)" "ON_HOLD(h!)" "|" "DONE(d!)")))
  ;; Insert log notes into LOGBOOK
  (setq org-log-into-drawer t)

  ;; Don't ask for confirmation on evaluate
  (setq org-confirm-babel-evaluate nil)
  ;; Load language support
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (shell . t)))

  ;; Agenda
  (setq org-agenda-files '("~/org/todo.org" "~/org/roles/" "~/org/projects/" "~/org/calendar/" "~/org/mobile/"))
  ;; Capture
  (setq org-capture-templates '(
                                ("j" "Journal entry" plain (function my//org-find-journal-location)
                                 "** %(format-time-string org-journal-time-format)%?\n%i")
                                ("b" "Backlog entry" entry (file+olp "todo.org" "Backlog")
                                 "** %?\n:LOGBOOK:\n- State \"CREATED\"                      %U\n:END:\n%i" :prepend t)
                                ("r" "Reminder" entry (file+olp "todo.org" "Backlog")
                                 "** REMINDER %?\nSCHEDULED: %^T\n:PROPERTIES:\n:APPT_WARNTIME: 0\n:END:\n%i" :prepend t)
                                ("w" "Capture web page" plain (function my//org-find-journal-location)
                                 "** %(format-time-string org-journal-time-format)%?\nTITLE: %:description\nURL: %:link\n\n%i")
                                ("p" "Capture primary selection" plain (function my//org-find-journal-location)
                                 "** %(format-time-string org-journal-time-format)%?\n\n%(my//get-primary-selection)")
                                ))
  :config
  ;; Customize ellipsis
  (setq org-ellipsis " …")
  (set-face-attribute 'org-ellipsis nil :underline nil)
  :bind (("C-c l" . 'org-store-link)
         ("C-c a" . 'org-agenda)
         ("C-c c" . 'org-capture))
  :hook (org-mode . org-indent-mode))
