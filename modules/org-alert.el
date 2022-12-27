(use-package alert
  :config
  (setq alert-default-style 'libnotify))

(use-package org-alert
  :demand t
  :config
  (setq org-alert-interval 300
      org-alert-notify-cutoff 15
      org-alert-notify-after-event-cutoff nil
      org-alert-notification-title "Emacs")
  (org-alert-enable))
