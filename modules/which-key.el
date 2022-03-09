(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-mode 1)
  :config
  (setq which-key-idle-delay 1000
        which-key-separator " "
        which-key-prefix-prefix ""))
