;; Get rid of minor modes
(diminish 'eldoc-mode)
(diminish 'abbrev-mode)

;; Show date in modeline
(setq display-time-format "%Y-%m-%d W%V ")
(setq display-time-default-load-average nil)
;; (display-time-mode 1)

;; Show column number
(column-number-mode 1)

(setq-default mode-line-format '("%e" " %*%* %b" mode-line-format-right-align  "L:%l C:%c"))

(add-hook 'after-init-hook (lambda ()
                             (set-face-attribute 'mode-line nil :background (face-background 'default) :box (list :line-width 8 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-active nil :background (face-background 'default) :foreground (face-foreground 'mode-line-buffer-id) :box (list :line-width 8 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-inactive nil :background (face-background 'default) :box (list :line-width 8 :color (face-background 'default)))))
