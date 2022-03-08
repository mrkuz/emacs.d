;; Disable automatic package rebuilding
(setq straight-check-for-modifications nil)

;; Bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Save some time and space
(setq straight-vc-git-default-clone-depth 1)

;; use-package integration
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

;; Show number of packages and initialization time on startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "%d packages loaded in %s seconds."
                     (hash-table-count straight--profile-cache)
                     (emacs-init-time "%.2f"))))
