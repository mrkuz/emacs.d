;; Allow setting dictionary as local file variable
(put 'ispell-dictionary 'safe-local-variable (lambda (_) t))
;; Inhibit default flyspell keymap
(setq flyspell-mode-map (make-sparse-keymap))
;; Configure hunspell
(setq-default ispell-program-name "hunspell")
(setenv "DICPATH" "/run/current-system/sw/share/hunspell/")
