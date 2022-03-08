;; Avoid garbage collection at startup
;; See: https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-does-doom-start-up-so-quickly
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216 ; 16 MiB
                  gc-cons-percentage 0.1)))

;; Prevent loading packages prior init file
(setq package-enable-at-startup nil)

;; Move gccemacs eln-cache to var/
(when (boundp 'native-comp-eln-load-path)
  (add-to-list 'native-comp-eln-load-path (expand-file-name "var/eln-cache" user-emacs-directory)))

;; Core functions for loading configs and modules
(defun my/load-config (name)
  "Load config by name."
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/config"))))

(defun my/load-module (name)
  "Load module by name."
  (load-file (expand-file-name (concat name ".el") (concat user-emacs-directory "/modules"))))
