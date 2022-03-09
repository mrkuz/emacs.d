;;--------------------------------------------------------------------------------------------------
;; Fonts
;;--------------------------------------------------------------------------------------------------

(set-frame-font "Ubuntu Mono")
(set-face-attribute 'default nil :family "Ubuntu Mono" :height 128)
(set-face-attribute 'fixed-pitch nil :family "Ubuntu Mono")
(set-face-attribute 'variable-pitch nil :family "Ubuntu")
(setq-default line-spacing 2)

;;--------------------------------------------------------------------------------------------------
;; Modeline
;;--------------------------------------------------------------------------------------------------

;; Get rid of minor modes
(diminish 'eldoc-mode)
(diminish 'abbrev-mode)

;; Show date in modeline
(setq display-time-format "%Y-%m-%d W%V")
(setq display-time-default-load-average nil)
(display-time-mode 1)

;; Show column number
(column-number-mode 1)

;;--------------------------------------------------------------------------------------------------
;; Cursor
;;--------------------------------------------------------------------------------------------------

;; Set cursor color
(set-cursor-color "#e1e1e0")
;; Disable blinking cursor
(blink-cursor-mode 0)
;; Set cursor to bar
;; (setq-default cursor-type 'bar)

;;--------------------------------------------------------------------------------------------------
;; Miscellaneous
;;--------------------------------------------------------------------------------------------------

;; Highlight current line
;; (global-hl-line-mode 1)
;; Show matching parens
(show-paren-mode 1)
;; Show line numbers
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode)))
;; Set fringe width
;; (setq-default left-fringe-width 12)
;; (setq-default right-fringe-width 12)
