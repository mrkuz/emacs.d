(use-package highlight-symbol
  :config
  (set-face-attribute 'highlight-symbol-face nil
                      :foreground (face-attribute 'highlight :foreground)
                      :background (face-attribute 'highlight :background))
  (setq highlight-symbol-idle-delay 0.5)
  (setq highlight-symbol-highlight-single-occurrence nil)
  :hook ((text-mode . highlight-symbol-mode)
         (prog-mode . highlight-symbol-mode)))
