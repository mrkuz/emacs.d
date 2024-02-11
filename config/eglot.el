(use-package eglot
  :elpaca nil
  :init
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")))))

