(defun my/company-advice (fn &rest args)
  (let ((completion-styles '(basic partial-completion flex)))
    (apply fn args)))

;; Use helpful for documentation
(defun my/company-show-doc ()
  (interactive)
  (let ((selected (nth company-selection company-candidates)))
    (if (intern-soft selected)
        (helpful-symbol (intern-soft selected))
      (ignore-error user-error (company-show-doc-buffer)))))

;; Update helpful buffer when select candidate
(defun my/company-doc-frontend (command)
  (pcase command
    ('post-command (if (get-buffer-window my/helpful-buffer) (my/company-show-doc)))))

(use-package company
  :diminish company-mode
  :bind (:map company-active-map ("C-h" . my/company-show-doc))
  :init
  (global-company-mode 1)
  :config
  (setq company-backends '(company-capf company-files company-dabbrev-code company-dabbrev)
        company-minimum-prefix-length 1
        company-idle-delay 0.4
        company-show-numbers t
        company-tooltip-limit 9
        ;; Keep candidate case
        company-dabbrev-downcase nil
        company-dabbrev-other-buffers nil)
  ;; Don't use orderless for completion
  (advice-add 'company-calculate-candidates :around #'my/company-advice)
  (add-to-list 'company-frontends 'my/company-doc-frontend :append))
