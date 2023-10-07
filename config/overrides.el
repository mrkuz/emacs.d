;; ChromeOS
(when (string-equal (system-name) "penguin")
  (setq default-frame-alist '((width . 120) (height . 34)))
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 120)
  (setq-default line-spacing 4))


(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 160)
  (setq-default line-spacing 4)
  (add-hook 'emacs-startup-hook (lambda () (x-focus-frame nil))))
