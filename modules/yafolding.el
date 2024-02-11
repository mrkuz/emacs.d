(defun my/yafolding-hide-region ()
  "Fold selected region."
  (interactive)
  (yafolding-hide-region (region-beginning) (region-end)))

(use-package yafolding
  :hook (help-mode . yafolding-mode))
