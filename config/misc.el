;; No dialog boxes
;; (setq use-dialog-box nil)
;; Disable bell
;; (setq ring-bell-function 'ignore)
;; Always ask for y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; Ask before exiting emacs
;; (setq confirm-kill-emacs 'yes-or-no-p)

;; Set fill column
(setq-default fill-column 120)

;; Enable all disabled commands
(setq disabled-command-hook nil)
(setq disabled-command-function nil)

;; Disable suspend-frame keybinding
(global-unset-key (kbd "C-z"))

;; Always follow links
(setq vc-follow-symlinks t)

;; Disable show matching parens
(show-paren-mode 0)

;; Enable completion with TAB
;; (setq tab-always-indent 'complete)
;; Enable completion with C-TAB
(global-set-key (kbd "<C-tab>") 'completion-at-point)

;; Disable blinking cursor
(blink-cursor-mode 0)
;; Set cursor to bar
;; (setq-default cursor-type 'bar)

;; Highlight current line
;; (global-hl-line-mode 1)

;; Enable indentation and completion using the TAB key
;; (setq tab-always-indent 'complete)

;; Show line numbers
(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode)
                            (set-face-attribute 'line-number-current-line nil :background 'unspecified)))

;; Set fringe width
;; (setq-default left-fringe-width 12)
;; (setq-default right-fringe-width 12)

;; Show all files on completion
(setq completion-ignored-extensions nil)
