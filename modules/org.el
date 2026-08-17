;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Base directory for Org files
(setq org-directory "~/org")

;; Open files with two levels shown
(setq org-startup-folded 'show2levels)

;; Keep drawers folded, so TAB reveals the body instead of the properties
(setq org-cycle-hide-drawer-startup t)
(add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

;; Indent by outline level
(setq org-startup-indented t
      org-indent-indentation-per-level 1)

;; Add tags immediately after the headline
(setq org-tags-column 0)

;; Customize ellipsis
(setq org-ellipsis " …")
(custom-set-faces '(org-ellipsis ((nil :underline nil))))

;; Every keyword logs a timestamp on entry
(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n!)" "SCHEDULED(.!)" "STAGED(:!)" "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c!)")
        (sequence "OPEN(o!)" "|" "DONE(d!)" "CANCELED(c!)")
        (sequence "REMINDER(r!)" "|" "DONE(d!)" "CANCELED(c!)")))

;; Collect those timestamps in a LOGBOOK drawer instead of below the headline
(setq org-log-into-drawer t)

;; Link to headings by ID, which survives renaming and refiling
(setq org-id-link-to-org-use-id t)

;; Report durations in hours and minutes, instead of rolling over into days
(setq org-duration-format 'h:mm)

;; Survive a restart with the clock still running
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

;; Binds the capture template list
(require 'org-capture)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//org-prompt-for-date ()
  "Prompt for a schedule or deadline after certain state changes."
  (let ((fn (cond
             ((member org-state '("SCHEDULED" "REMINDER")) #'org-schedule)
             ((equal org-state "STAGED") #'org-deadline)))
        (marker (point-marker)))
    (when fn
      ;; Deferred, so the prompt runs after `org-todo' has finished
      (run-at-time 0 nil (lambda ()
                           (org-with-point-at marker (funcall fn nil))
                           (set-marker marker nil))))))
(add-hook 'org-after-todo-state-change-hook #'my//org-prompt-for-date)

(defun my/org-set-added ()
  "Stamp the heading at point with an ADDED property."
  (interactive)
  ;; Not CREATED: org-journal reserves that name for its own %Y%m%d date index
  (org-set-property "ADDED" (format-time-string (org-time-stamp-format t t))))

(defun my/org-open-todo ()
  "Open todo.org in the Org directory."
  (interactive)
  (find-file (expand-file-name "todo.org" org-directory)))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(global-set-key (kbd "C-c c") 'org-capture)

;; Global, so links can be stored from any buffer, not just Org ones
(global-set-key (kbd "C-c l") 'org-store-link)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-x C") 'my/org-set-added)
  ;; Org's own defaults, spelled out so they survive a stray rebinding
  (define-key org-mode-map (kbd "C-c C-l") 'org-insert-link)
  (define-key org-mode-map (kbd "C-c C-o") 'org-open-at-point))
