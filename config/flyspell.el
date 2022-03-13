;; Allow setting dictionary as local file variable
(put 'ispell-dictionary 'safe-local-variable (lambda (_) t))
;; Inhibit default flyspell keymap
(setq flyspell-mode-map (make-sparse-keymap))
