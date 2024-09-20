;; Get rid of minor modes
(diminish 'eldoc-mode)
(diminish 'abbrev-mode)

;; Show date in modeline
(setq display-time-format "%Y-%m-%d W%V ")
(setq display-time-default-load-average nil)
;; (display-time-mode 1)

;; Show column number
(column-number-mode 1)

(add-hook 'after-init-hook (lambda ()
                             (set-face-attribute 'mode-line nil :background (face-background 'default) :box (list :line-width 8 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-active nil :background (face-background 'default) :foreground (face-foreground 'mode-line-buffer-id) :box (list :line-width 8 :color (face-background 'default)))
                             (set-face-attribute 'mode-line-inactive nil :background (face-background 'default) :box (list :line-width 8 :color (face-background 'default)))))

;; Keep mode-line simple per default, but show more info if minibuffer is visible
(setq my//mode-line-format-short '("%e" " %*%* %b " mode-line-format-right-align " L:%l C:%c"))
(setq my//mode-line-format-long '("%e" " %*%* %b" mode-line-format-right-align mode-name " L:%l C:%c"))
(setq-default mode-line-format my//mode-line-format-short)

(defun my//minibuffer-setup-mode-line-hook ()
  (with-selected-window (minibuffer-selected-window)
    (with-current-buffer (current-buffer)
      (setq mode-line-format my//mode-line-format-long))))
(add-hook 'minibuffer-setup-hook 'my//minibuffer-setup-mode-line-hook)

(defun my//minibuffer-exit-mode-line-hook ()
  (with-selected-window (minibuffer-selected-window)
    (with-current-buffer (current-buffer)
      (setq mode-line-format my//mode-line-format-short))))
(add-hook 'minibuffer-exit-hook 'my//minibuffer-exit-mode-line-hook)
