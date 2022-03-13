(use-package ibuffer
  :straight (:type built-in)
  :config
  ;; Always use new window
  (setq ibuffer-use-other-window t)
  :bind (([remap list-buffers] . 'ibuffer)))
