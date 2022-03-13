;; No dialog boxes
(setq use-dialog-box nil)
;; Disable bell
(setq ring-bell-function 'ignore)
;; Always ask for y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; Ask before exiting emacs
;; (setq confirm-kill-emacs 'yes-or-no-p)

;; Set fill column
(setq-default fill-column 100)

;; Enable all disabled commands
(setq disabled-command-hook nil)
(setq disabled-command-function nil)

;; Always follow links
(setq vc-follow-symlinks t)

;; Automatically close parens
(electric-pair-mode 1)
;; Don't insert closing pair before non-whitespace characters
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
;; Show matching parens
(show-paren-mode 1)

;; Set cursor color
(set-cursor-color "#e1e1e0")
;; Disable blinking cursor
(blink-cursor-mode 0)
;; Set cursor to bar
;; (setq-default cursor-type 'bar)

;; Highlight current line
;; (global-hl-line-mode 1)
;; Show line numbers
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode)))

;; Set fringe width
;; (setq-default left-fringe-width 12)
;; (setq-default right-fringe-width 12)
