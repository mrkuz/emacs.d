(use-package markdown-mode
  :mode (("\\.md\\'" . gfm-mode))
  :config
  (setq markdown-command "pandoc -t html5"))
