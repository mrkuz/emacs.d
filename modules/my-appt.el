(require 'notifications)

(defun my//appt-display (min-to-app new-time msg)
  (setq pretty (replace-regexp-in-string "\\(SCHEDULED\\|EVENT\\) " "" msg))
  (notifications-notify
   :title (format "Appointment in %s minutes" min-to-app)
   :body (format "%s" pretty)
   :timeout -1))

(setq appt-message-warning-time 15
      appt-display-duration 60
      appt-display-interval 5
      appt-display-mode-line nil
      appt-audible nil
      appt-display-diary nil
      appt-display-format 'window)
(setq appt-disp-window-function 'my//appt-display)

(appt-activate 1)
(run-with-idle-timer 10 t 'org-agenda-to-appt)
