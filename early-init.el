;; Avoid garbage collection at startup
;; See: https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-does-doom-start-up-so-quickly
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216 ; 16 MiB
                  gc-cons-percentage 0.1)))

;; Don’t compact font caches during GC
(setq inhibit-compacting-font-caches t)

;; Prevent loading packages prior init file
(setq package-enable-at-startup nil)

;; Move eln-cache to var/
;; See: https://github.com/emacscollective/no-littering/tree/main
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))


;; Show warning buffer only for errors
(setq warning-minimum-level :error)
;; Enter debugger on error
(setq debug-on-error t)
;; Workaround for void variable error
;; (defvar native-comp-deferred-compilation-deny-list nil)

;; Show initialization time on startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Started in %s seconds"
                     (emacs-init-time "%.2f"))))

;;--------------------------------------------------------------------------------------------------
;; Custom functions
;;--------------------------------------------------------------------------------------------------

(defun my/load-config (name)
  "Load config by name."
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/config"))))

(defun my/load-module (name)
  "Load module by name."
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/modules"))))

;;--------------------------------------------------------------------------------------------------
;; Appearance
;;--------------------------------------------------------------------------------------------------

;; Set up initial frame position and size
(setq default-frame-alist '(
                            (width . 140)
                            (height . 50)
                            ;; (cursor-color . "#e1e1e0")
                            (internal-border-width . 8)
                            (undecorated-round . t)
                            ))
;; Show buffer name in frame title
(setq-default frame-title-format '("%b"))

;; Disable toolbar
(tool-bar-mode 0)
;; Disable menu bar
(menu-bar-mode 0)
;; Disable scroll bar
(scroll-bar-mode 0)
