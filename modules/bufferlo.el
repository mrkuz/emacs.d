(use-package bufferlo
  :bind (([remap switch-to-buffer] . bufferlo-switch-to-buffer)
         ("C-x B" . bufferlo-find-buffer-switch))
  :config
  (bufferlo-mode 1))
