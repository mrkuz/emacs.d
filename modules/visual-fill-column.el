(defun my/visual-line-mode-hook ()
  (if (bound-and-true-p visual-fill-column-mode)
      (visual-fill-column-mode -1)
    (visual-fill-column-mode 1)))

(use-package visual-fill-column
  :hook (visual-line-mode . my/visual-line-mode-hook))
