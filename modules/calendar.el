;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Match the ISO weeks the journal and archive are named after
(setq calendar-week-start-day 1
      calendar-date-style 'iso)

;; The default list is US civic holidays
(setq calendar-holidays (append holiday-general-holidays holiday-christian-holidays))
