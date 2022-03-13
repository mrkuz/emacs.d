(use-package crux
  :bind (([remap kill-line] . 'crux-smart-kill-line))
  :config
  ;; If no region is selected, untabify whole buffer
  (crux-with-region-or-buffer untabify))
