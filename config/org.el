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

;; As for timestamp for some items
(defun my//org-trigger-hook (args)
  (setq new-state (plist-get args :to))
  (when (or (string-equal new-state "SCHEDULED")
            (string-equal new-state "REMINDER"))
    (run-with-timer 0 nil (lambda () (org-schedule t))))
  (when (string-equal new-state "STAGED")
    (run-with-timer 0 nil (lambda () (org-deadline t)))))
(add-hook 'org-trigger-hook 'my//org-trigger-hook)

(use-package org
  :ensure nil
  :init
  (require 'org-mouse)
  (setq org-directory "~/org")
  ;; Open files with two levels open
  (setq org-startup-folded 'show2levels)

  ;; Add tags immediate after the headline
  (setq org-tags-column 0)
  ;; Hide ephasis marker characters
  (setq org-hide-emphasis-markers t)
  ;; Customize ellipsis
  (setq org-ellipsis " …")
  (set-face-attribute 'org-ellipsis nil :underline nil)
  ;; Never add blank lines before new entries
  ;; (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

  ;; Stop after TODO keyword and before tags on first C-a/C-e
  (setq org-special-ctrl-a/e t)

  ;; TODO keywords
  (setq org-todo-keywords '(
                            (sequence "TODO(t!)" "NEXT(n!)" "SCHEDULED(.!)" "STAGED(:!)" "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "OPEN(o!)" "|" "DONE(d!)")
                            (sequence "REMINDER(r!)" "|" "DONE(d!)")
                            (sequence "PROJECT(p!)" "ON_HOLD(h!)" "|" "DONE(d!)" "CANCELED(c!)")))
  ;; Insert log notes into LOGBOOK
  (setq org-log-into-drawer t)
  :bind (("C-c l" . 'org-store-link)))
