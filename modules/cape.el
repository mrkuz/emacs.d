(use-package cape
  :init
  (setq cape-dabbrev-min-length 1)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

