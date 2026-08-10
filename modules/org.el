;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Base directory for Org files
(setq org-directory "~/org")

;; Keep drawers folded, so TAB reveals the body instead of the properties
(setq org-cycle-hide-drawer-startup t)
(add-hook 'org-cycle-hook #'org-cycle-hide-drawers)

;; Needed to answer org-protocol:// URLs; org-capture binds the template list
(require 'org-protocol)
(require 'org-capture)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my/org-open-todo ()
  "Open todo.org in the Org directory."
  (interactive)
  (find-file (expand-file-name "todo.org" org-directory)))

(defun my//org-protocol-capture-single-window ()
  "Give the capture buffer the whole dedicated org-protocol frame."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-other-windows)))
(add-hook 'org-capture-mode-hook #'my//org-protocol-capture-single-window)

(defun my//org-protocol-capture-cleanup (&rest _)
  "Delete the dedicated org-protocol capture frame once capture ends."
  (when (equal (frame-parameter nil 'name) "org-protocol-capture")
    (delete-frame)))
(add-hook 'org-capture-after-finalize-hook #'my//org-protocol-capture-cleanup)
