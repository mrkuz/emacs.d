(use-package git-gutter
   :diminish git-gutter-mode
   :init
   (global-git-gutter-mode +1)
   (setq git-gutter:modified-sign "│")
   (setq git-gutter:deleted-sign"│")
   (setq git-gutter:added-sign "│"))
