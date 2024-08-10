(use-package which-key
  :diminish which-key-mode
  :init
  (setq which-key-separator " "
        which-key-prefix-prefix ""
        which-key-max-description-length nil)
  (which-key-mode 1)
  (which-key-enable-god-mode-support 1))
