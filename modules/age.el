(use-package age
  :init
  (setq age-default-identity "~/.ssh/id_rsa"
        age-default-recipient '("~/.ssh/id_rsa.pub"))
  :config
  (age-file-enable))

