;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; No `substring': `partial-completion' answers first for every input it
;; handles, so it would never be reached
(setq completion-styles '(basic partial-completion flex))

;; Let `partial-completion' fragments match anywhere in a candidate, not only
;; at the start of a word
(setq completion-pcm-leading-wildcard t)

;; Vertico owns the minibuffer, so the settings below shape the *Completions*
;; buffer that in-buffer completion still uses

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

;; Only active while a *Completions* window is showing, so point movement is
;; unaffected the rest of the time
(keymap-set completion-in-region-mode-map "C-n"
            (minibuffer-visible-completions--bind #'minibuffer-next-completion))
(keymap-set completion-in-region-mode-map "C-p"
            (minibuffer-visible-completions--bind #'minibuffer-previous-completion))
