(use-package hide-mode-line
  ;; Show modeline if minibuffer becomes visible
  :hook ((minibuffer-setup . my//minibuffer-setup-show-mode-line)
         (minibuffer-exit . my//minibuffer-exit-hide-mode-line))
  :init
  (setq hide-mode-line-format "")
  (global-hide-mode-line-mode))

(defun my//minibuffer-setup-show-mode-line ()
  (with-selected-window (minibuffer-selected-window)
    (with-current-buffer (current-buffer)
      (hide-mode-line-mode -1))))

(defun my//minibuffer-exit-hide-mode-line ()
  (with-selected-window (minibuffer-selected-window)
    (with-current-buffer (current-buffer)
      (hide-mode-line-mode 1))))
