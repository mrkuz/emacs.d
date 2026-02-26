;; Prevent loading packages prior init file
(setq package-enable-at-startup nil)

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//load-module (name)
  "Load module by name"
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/modules"))))
