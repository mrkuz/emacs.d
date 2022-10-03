(use-package multiple-cursors
  :init
  (add-hook 'multiple-cursors-mode-enabled-hook (lambda () (hungry-delete-mode -1)))
  (add-hook 'multiple-cursors-mode-disabled-hook (lambda () (hungry-delete-mode 1))))

