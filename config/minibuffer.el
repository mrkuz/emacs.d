;; See: https://github.com/minad/vertico

;; Enable recursive minibuffers
;; (setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; Keep cursor out of minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Persist history over restarts
(use-package savehist
  :ensure nil
  :init
  (savehist-mode)
  (setq history-length 100))

;; Add prompt indicator when reading multiple strings ('completing-read-multiple')
(defun my//crm-indicator (args)
  (cons (format "[CRM %s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'my//crm-indicator)
