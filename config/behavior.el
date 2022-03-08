;;--------------------------------------------------------------------------------------------------
;; Start-up
;;--------------------------------------------------------------------------------------------------

;; Don't load default init
(setq inhibit-default-init t)
;; Disable splash screen
(setq inhibit-splash-screen t)
;; Empty *scratch* buffer
(setq initial-scratch-message nil)

;;--------------------------------------------------------------------------------------------------
;; Minibuffer
;;--------------------------------------------------------------------------------------------------

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

;; Keep cursor out of prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Persist history over restarts
(savehist-mode)
