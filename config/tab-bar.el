(tab-bar-mode)
;; Always show tab bar
(setq tab-bar-show t
      ;; Hide close button
      tab-bar-close-button-show nil
      ;; Don't stretch buttons
      tab-bar-auto-width nil
      tab-bar-separator "  "
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator)
      tab-bar-new-tab-choice "*scratch*")

(add-hook 'after-init-hook (lambda ()
                             (set-face-attribute 'tab-bar nil :box (list :line-width 8 :color (face-background 'default)))
                             (set-face-attribute 'tab-bar-tab nil :underline nil)))
