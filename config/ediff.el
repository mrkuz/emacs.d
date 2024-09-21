;; Use window instead of control frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ;; Compare side by side
      ediff-split-window-function 'split-window-horizontally)
