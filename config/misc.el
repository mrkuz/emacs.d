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

;; Disable suspend-frame keybinding
(global-unset-key (kbd "C-z"))

;; Always follow links
(setq vc-follow-symlinks t)

;; Automatically close parens
(electric-pair-mode 1)
;; Don't insert closing pair before non-whitespace characters and for '<'
(setq-default electric-pair-inhibit-predicate
              (lambda (c)
                (cond
                 ((char-equal c ?<) t)
                 ((eq (char-after) nil) nil)
                 ((eq (char-syntax (char-after)) ?w) t))))
;; Disable show matching parens
(show-paren-mode 0)

;; Show number of matches when searching
(setq isearch-lazy-count t)

;; Enable completion with TAB
;; (setq tab-always-indent 'complete)
;; Enable completion with C-TAB
(global-set-key (kbd "<C-tab>") 'completion-at-point)

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
