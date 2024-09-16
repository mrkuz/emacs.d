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

;; Enable indentation and completion using the TAB key
;; (setq tab-always-indent 'complete)
;; Enable completion with C-TAB
(global-set-key (kbd "<C-tab>") 'completion-at-point)

;; Disable blinking cursor
(blink-cursor-mode 0)
;; Set cursor to bar
;; (setq-default cursor-type 'bar)

;; Highlight current line
;; (global-hl-line-mode 1)

;; Prettify symbols
(setq prettify-symbols-unprettify-at-point t)
(global-prettify-symbols-mode)

;; Show line numbers
(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode)
                            (set-face-attribute 'line-number-current-line nil :background 'unspecified)))

;; Configure fringe
(setq-default left-fringe-width 10)
(setq-default right-fringe-width 10)
(setq-default indicate-buffer-boundaries 'right)

;; Show all files on completion
(setq completion-ignored-extensions nil)

;; Enable window dividers
(setq window-divider-default-places 'bottom-only
      window-divider-default-right-width 1
      window-divider-default-bottom-width 1)
(add-hook 'after-init-hook (lambda ()
                             (set-face-foreground 'window-divider (face-attribute 'vertical-border :foreground))))
(window-divider-mode)

;; Use header-line to create some space at the top of each window
;; (setq-default header-line-format "")
;; (add-hook 'after-init-hook (lambda ()
;;                             (set-face-attribute 'header-line nil :background (face-background 'default) :height 100 :box nil)))

;; Use tab-line to create some space at the top of each window
;; (setq tab-line-tabs-function (lambda '()))
;; (global-tab-line-mode)
;; (add-hook 'after-init-hook (lambda ()
;;                              (set-face-attribute 'tab-line nil :background (face-background 'default) :height 100)))

;; Message buffer name after switching
;; (add-hook 'buffer-list-update-hook (lambda () (message (buffer-name (current-buffer)))))
