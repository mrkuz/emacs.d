;; ChromeOS
(when (string-equal (system-name) "penguin")
  (setq default-frame-alist '((width . 120) (height . 34)))
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 120)
  (setq-default line-spacing 4))

;; MacOS
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 160)
  (setq-default line-spacing 4)
  (setq mac-right-option-modifier 'none)
  ;; Focus frame after start
  (add-hook 'emacs-startup-hook (lambda ()
                                  (if (not (daemonp))
                                      (x-focus-frame nil))))
  (add-hook 'server-after-make-frame-hook (lambda () (x-focus-frame nil))))
