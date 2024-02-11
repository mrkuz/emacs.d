(use-package eglot
  :elpaca nil
  :init
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(lua-mode . ("lua-lsp"))
                 '(nix-ts-mode . ("nil"))
                 )))
