(use-package crux
  :config
  ;; If no region is selected, untabify whole buffer
  (crux-with-region-or-buffer untabify))
