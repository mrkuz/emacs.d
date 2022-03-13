(setq yas-snippet-dirs `(,(expand-file-name "snippets" user-emacs-directory)))
(use-package yasnippet
  :diminish yas-minor-mode
  :init
  (yas-global-mode 1)
  :config
  (setq yas-prompt-functions '(yas-completing-prompt)))
