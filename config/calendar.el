(use-package calendar
  :ensure nil
  :init
  ;; Configure calendar holidays
  (setq calendar-holidays (append holiday-general-holidays holiday-christian-holidays))
  ;; Start week with monday
  (setq calendar-week-start-day 1)
  ;; Use ISO date format
  (setq calendar-date-style 'iso))

