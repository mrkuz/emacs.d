(require 'ibuf-ext)

(defun my//file-buffer-p (buffer)
  (with-current-buffer buffer
    (not (buffer-file-name buffer))))

(defun my//ibuffer-sidebar-mode-hook ()
  (with-current-buffer ibuffer-sidebar-name
    (make-local-variable 'ibuffer-never-show-predicates)
    (add-to-list 'ibuffer-never-show-predicates #'my//file-buffer-p)))

(use-package ibuffer-sidebar
  :init
  (setq ibuffer-sidebar-refresh-timer 1
        ibuffer-sidebar-display-summary nil
        ibuffer-sidebar-display-column-titles nil
        ibuffer-sidebar-mode-line-format '(""))
  :hook (ibuffer-sidebar-mode . my//ibuffer-sidebar-mode-hook))
