;; To install fonts, run 'nerd-icons-install-font'
(use-package nerd-icons)

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; Don't activate nerd-icons for derived modes
;; (workaround for issues with 'ibuffer-sidebar')
(defun my//ibuffer-mode-hook ()
   (if (eq major-mode 'ibuffer-mode)
       (nerd-icons-ibuffer-mode)))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . my//ibuffer-mode-hook))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
