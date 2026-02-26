;; Prevent GC at startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1.0)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)))

;; Increase read process output
(setq read-process-output-max (* 1024 1024))

;; -------------------------------------------------------------------------------------------------
;; Configuration
;; -------------------------------------------------------------------------------------------------

;; Don't load default initialization file
(setq inhibit-default-init t)
;; Prevent loading packages prior init file
(setq package-enable-at-startup nil)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Disable toolbar
(tool-bar-mode 0)
;; Disable menu bar
(menu-bar-mode 0)
;; Disable scroll bar
(scroll-bar-mode 0)

;; Allow frame resizing by pixel
(setq frame-resize-pixelwise t)

;; Set up initial frame position and size
(setq default-frame-alist '(
                            (width . 140)
                            (height . 50)
                            ;; (internal-border-width . 12)
                            ;; (undecorated-round . t)
                            ))

;; -------------------------------------------------------------------------------------------------
;; MacOS
;; -------------------------------------------------------------------------------------------------

(when (eq system-type 'darwin)
  ;; Don't use right option key as meta
  (setq mac-right-option-modifier 'none)
  ;; Raise frame after start
  (add-hook 'emacs-startup-hook (lambda ()
                                  (if (not (daemonp))
                                      (x-focus-frame nil))))
  (add-hook 'server-after-make-frame-hook (lambda () (x-focus-frame nil))))

;; -------------------------------------------------------------------------------------------------
;; Functions
;; -------------------------------------------------------------------------------------------------

(defun my//load-module (name)
  "Load module by name"
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/modules"))))
