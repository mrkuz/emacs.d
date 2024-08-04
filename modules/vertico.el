(defun my//vertico-help ()
  (interactive)
  (let ((symbol (intern-soft (vertico--candidate))))
    (if symbol (describe-symbol symbol))))

(use-package vertico
  :init
  (vertico-mode)
  (keymap-set vertico-map "C-h" #'my//vertico-help))

;; Configure directory extension
;; See: https://github.com/minad/vertico
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; Ido-like directory navigation
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
