(defun my/company-advice (fn &rest args)
  (let ((completion-styles '(basic partial-completion flex)))
    (apply fn args)))

(use-package company
  :diminish company-mode
  :init
  (global-company-mode 1)
  :config
  (setq company-backends '(company-capf company-files company-dabbrev)
        company-minimum-prefix-length 1
        company-idle-delay 0.4
        company-show-numbers t
        company-tooltip-limit 9
        ;; Keep candidate case
        company-dabbrev-downcase nil
        company-dabbrev-other-buffers nil)
  ;; Don't use orderless for completion
  (advice-add 'company-calculate-candidates :around #'my/company-advice))
