;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Keep point out of the prompt, which plain character motion walks into
(setopt minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Hide commands that do not apply to the current mode from `M-x'
(setq read-extended-command-predicate #'command-completion-default-include-p)
