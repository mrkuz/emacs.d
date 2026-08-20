;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Keeps point out of the prompt
(setopt minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Hide commands that do not apply to the current mode from `M-x'
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Allow a prompt on top of a prompt, with the depth shown so it stays clear
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)
