(use-package dabbrev
  :ensure nil
  :config
  ;; See: https://github.com/company-mode/company-mode/blob/master/company-dabbrev.el
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\`[ *]"))
