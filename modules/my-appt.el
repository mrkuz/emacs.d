(require 'notifications)

(defun my/reminder (message time)
  "Set up reminder"
  (interactive "sMessage: \nsTime (HH:MM): ")
  (message time)
  (appt-add time message 0))

(defun my//appt-display (min-to-app new-time msg)
  (setq time (substring msg 0 5))
  (setq content (substring msg 6))
  (if (string= "0" min-to-app)
      (notifications-notify
       :title (format "%s" content)
       :timeout 60)
    (notifications-notify
     :title (format "%s" content)
     :body (format "in %s minutes (%s)" min-to-app time)
     :timeout 60)))

(setq appt-message-warning-time 15
      appt-display-duration 60
      appt-display-interval 5
      appt-display-mode-line nil
      appt-audible nil
      appt-display-diary nil
      appt-display-format 'window)
(setq appt-disp-window-function 'my//appt-display)

(when (daemonp)
  (appt-activate 1)
  (run-with-idle-timer 10 t 'org-agenda-to-appt))
