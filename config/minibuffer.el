;; Enable recursive minibuffers
;; (setq enable-recursive-minibuffers t)
;; (minibuffer-depth-indicate-mode 1)

;; Keep cursor out of prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Persist history over restarts
(savehist-mode)
(setq history-length 100)

;; Add indicator when read multiple strings
(defun my//crm-indicator (args)
  (cons (concat "[CRM] " (car args)) (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'my//crm-indicator)
