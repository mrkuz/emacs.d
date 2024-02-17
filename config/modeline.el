;; Get rid of minor modes
(diminish 'eldoc-mode)
(diminish 'abbrev-mode)

;; Show date in modeline
(setq display-time-format "%Y-%m-%d W%V")
(setq display-time-default-load-average nil)
(display-time-mode 1)

;; Show column number
(column-number-mode 1)
