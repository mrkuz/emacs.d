(defun my/dired-sidebar-follow-file ()
  "Show current file in sidebar"
  (interactive)
  (dired-sidebar-follow-file))

(use-package dired-sidebar
  :init
  (setq dired-sidebar-should-follow-file nil
        dired-sidebar-mode-line-format '("")
        dired-use-ls-dired nil
        dired-sidebar-no-delete-other-windows t
        dired-sidebar-pop-to-sidebar-on-toggle-open nil))
