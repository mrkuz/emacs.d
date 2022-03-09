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
;; Whitespace
;;--------------------------------------------------------------------------------------------------

;; Tab width
(setq-default tab-width 4)
;; Always use spaces
(setq-default indent-tabs-mode nil)
;; Set up tab stop list
(setq tab-stop-list '(0 tab-width))

;;--------------------------------------------------------------------------------------------------
;; Undo
;;--------------------------------------------------------------------------------------------------

;; Use linear undo
(global-set-key [remap undo] 'undo-only)
(global-set-key (kbd "C-x U") 'undo-redo)

;;--------------------------------------------------------------------------------------------------
;; Scrolling
;;--------------------------------------------------------------------------------------------------

;; Move cursor to first/last line when hit top/bottom
(setq scroll-error-top-bottom t)
;; Keep cursor position when scrolling pages
(setq scroll-preserve-screen-position t)
;; Try to keep 5 lines visible when scrolling
(setq scroll-step 5)

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
(setq history-length 100)

;;--------------------------------------------------------------------------------------------------
;; Backups
;;--------------------------------------------------------------------------------------------------

;; Disable backup files
;; (setq make-backup-files nil)
;; Make numeric backups
(setq version-control t)
;; Keep all backups
(setq delete-old-versions -1)
;; Disable auto save
;; (setq auto-save-default nil)

;;--------------------------------------------------------------------------------------------------
;; Calendar
;;--------------------------------------------------------------------------------------------------

;; Configure calendar holidays
(setq calendar-holidays (append holiday-general-holidays holiday-christian-holidays))
;; Start week with monday
(setq calendar-week-start-day 1)
;; Use ISO date format
(setq calendar-date-style 'iso)

;;--------------------------------------------------------------------------------------------------
;; Projects
;;--------------------------------------------------------------------------------------------------

;; .project marks directory as root of project
(defun my/project-find-root (dir)
  (let ((root (locate-dominating-file dir ".project")))
    (if root (cons 'transient root) nil)))

(use-package project
  :straight (:type built-in)
  :config
  (add-to-list 'project-find-functions 'my/project-find-root))

;;--------------------------------------------------------------------------------------------------
;; dired
;;--------------------------------------------------------------------------------------------------

;; Reuse buffer
(use-package dired
  :straight (:type built-in)
  :bind (:map dired-mode-map ("RET" . 'dired-find-alternate-file)))

;;--------------------------------------------------------------------------------------------------
;; recentf
;;--------------------------------------------------------------------------------------------------

(use-package recentf
  :straight (:type built-in)
  :init
  (recentf-mode)
  :config
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

;;--------------------------------------------------------------------------------------------------
;; Miscellaneous
;;--------------------------------------------------------------------------------------------------

;; No dialog boxes
(setq use-dialog-box nil)
;; Disable bell
(setq ring-bell-function 'ignore)

;; Set fill column
(setq-default fill-column 100)

;; Always ask for y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Ask before exiting emacs
;; (setq confirm-kill-emacs 'yes-or-no-p)

;; Enable all disabled commands
(setq disabled-command-hook nil)
(setq disabled-command-function nil)

;; Always follow links
(setq vc-follow-symlinks t)
