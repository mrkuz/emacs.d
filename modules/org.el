;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Base directory for Org files
(setq org-directory "~/org")

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

;; Binds the capture template list
(require 'org-capture)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/org-set-created ()
  "Stamp the heading at point with a CREATED property."
  (interactive)
  (org-set-property "CREATED" (format-time-string (org-time-stamp-format t t))))

(defun my/org-open-todo ()
  "Open todo.org in the Org directory."
  (interactive)
  (find-file (expand-file-name "todo.org" org-directory)))

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(global-set-key (kbd "C-c c") 'org-capture)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-x C") 'my/org-set-created))
