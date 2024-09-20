(use-package bufferlo
  :bind (([remap switch-to-buffer] . bufferlo-find-buffer-switch)
         ("C-x B" . bufferlo-switch-to-buffer))
  :config
  (bufferlo-mode 1))
