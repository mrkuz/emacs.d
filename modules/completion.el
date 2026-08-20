;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; `substring' is left out: `partial-completion' always answers first
(setq completion-styles '(basic partial-completion flex))

;; Lets `partial-completion' match anywhere in a candidate
(setq completion-pcm-leading-wildcard t)

(setq completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; Vertico owns the minibuffer; the rest is for in-buffer completion

;; Show candidates right away and keep them current while typing
(setq completion-eager-display t
      completion-eager-update t)

;; Cap the window, and drop the "Click or type M-RET…" instructions
(setq completions-max-height 15
      completion-show-help nil)

;; One candidate per line, so stepping is linear
(setq completions-format 'one-column)

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

;; Only active while a *Completions* window is showing
(keymap-set completion-in-region-mode-map "C-n"
            (minibuffer-visible-completions--bind #'minibuffer-next-completion))
(keymap-set completion-in-region-mode-map "C-p"
            (minibuffer-visible-completions--bind #'minibuffer-previous-completion))
