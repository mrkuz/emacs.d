(defun my/hide-region ()
  (interactive)
  (yafolding-hide-region (region-beginning) (region-end)))

(use-package yafolding
  :init
  :hook (help-mode . yafolding-mode))
