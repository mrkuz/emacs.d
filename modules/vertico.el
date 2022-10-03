(use-package vertico
  :straight '(vertico :files (:defaults "extensions/*")
                      :includes (vertico-directory))
  :init
  (vertico-mode)
  ;; Ido-like directory navigation
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
