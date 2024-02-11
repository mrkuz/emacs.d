(use-package yasnippet
  :diminish yas-minor-mode
  :init
  (setq yas-snippet-dirs `(,(expand-file-name "snippets" user-emacs-directory)))
  ;; Use completion-read to select snippets
  (setq yas-prompt-functions '(yas-completing-prompt))
  (yas-global-mode 1))
