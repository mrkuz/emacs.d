(use-package corfu
  :init
  (setq corfu-auto t
        corfu-auto-prefix 1
        corfu-auto-delay 0.4
        corfu-min-width 40
        corfu-popupinfo-min-width 40
        corfu-popupinfo-max-height 20
        corfu-popupinfo-delay '(1.0 . 0.0))
  (global-corfu-mode)
  (corfu-popupinfo-mode))

