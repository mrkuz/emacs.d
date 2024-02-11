(use-package ibuffer
  :elpaca nil
  :init
  ;; Always use new window
  (setq ibuffer-use-other-window t)
  :bind (
         ([remap list-buffers] . 'ibuffer)
         :map ibuffer-name-map
         ("<mouse-1>" . ibuffer-visit-buffer-1-window)
         ("<mouse-2>" . ibuffer-mouse-toggle-mark)))
