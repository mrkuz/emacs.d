(defun my//restclient-mode-hook ()
  (add-to-list 'company-backends 'company-restclient))

(use-package restclient
  :mode ("\\.rest\\'" . restclient-mode)
  :commands restclient-mode
  :hook (restclient-mode . my//restclient-mode-hook))

(use-package company-restclient)
