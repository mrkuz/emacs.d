;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; No `substring': `partial-completion' answers first and it would never be reached
(setq completion-styles '(basic partial-completion flex))

;; Let `partial-completion' match anywhere, not only at word starts
(setq completion-pcm-leading-wildcard t)

;; Vertico owns the minibuffer; the rest shapes the buffer in-buffer completion uses

;; Show candidates right away and keep them current while typing
(setq completion-eager-display t
      completion-eager-update t)

;; Cap the window, and drop the "Click or type M-RET…" instructions
(setq completions-max-height 15
      completion-show-help nil)

;; One candidate per line, so stepping through them is linear
(setq completions-format 'one-column)

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

;; Only active while a *Completions* window is showing
(keymap-set completion-in-region-mode-map "C-n"
            (minibuffer-visible-completions--bind #'minibuffer-next-completion))
(keymap-set completion-in-region-mode-map "C-p"
            (minibuffer-visible-completions--bind #'minibuffer-previous-completion))
