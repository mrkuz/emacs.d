;; ChromeOS
(when (string-equal (system-name) "penguin")
  (setq default-frame-alist '((width . 120) (height . 34)))
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 120)
  (setq-default line-spacing 4))

