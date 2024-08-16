;; Get rid of minor modes
(diminish 'eldoc-mode)
(diminish 'abbrev-mode)

;; Show date in modeline
(setq display-time-format "%Y-%m-%d W%V ")
(setq display-time-default-load-average nil)
(display-time-mode 1)

;; Show column number
(column-number-mode 1)

(add-hook 'after-init-hook (lambda ()
                             ;; Add some spacing around modeline
                             (set-face-attribute 'mode-line nil :box (list :line-width 5 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-active nil :box (list :line-width 5 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-inactive nil :box (list :line-width 5 :color (face-background 'default)))
                             ;; Use default background color for when inactive
                             (set-face-attribute 'mode-line-inactive nil :background (face-background 'default))))
