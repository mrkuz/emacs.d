(defvar my//selected "")

;; Set up completion styles
(defun my//company-advice (fn &rest args)
  (let ((completion-styles '(basic partial-completion flex)))
    (apply fn args)))

;; Use helpful for documentation
(defun my/company-show-doc ()
  "Show documentation for seletion."
  (interactive)
  (let* (
        (selected (nth company-selection company-candidates))
        (symbol (intern-soft selected)))
    (if symbol
        (if (string-equal selected my//selected)
            ;; Scroll if symbol is already shown
            (with-current-buffer my//helpful-buffer
              (with-selected-window (get-buffer-window)
                (ignore-error scan-error (scroll-up-command 1))))
          (helpful-symbol symbol))
      (ignore-error user-error (company-show-doc-buffer)))
    (setq my//selected selected)))

;; Update helpful buffer when select candidate
(defun my//company-doc-frontend (command)
  (pcase command
    ('post-command
     (when (and (get-buffer-window my//helpful-buffer)
                ;; On first <C-h> company-doc-frontend gets called twice (not sure why),
                ;; but we want to call my/company-show-doc only once.
                (not (string-equal (nth company-selection company-candidates) my//selected)))
       (setq my//selected "")
       (my/company-show-doc)))))

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
  ;; Don't use orderless for company completion
  (advice-add 'company-calculate-candidates :around #'my//company-advice)
  (add-to-list 'company-frontends 'my//company-doc-frontend :append))
