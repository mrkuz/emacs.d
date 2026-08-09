;; -*- lexical-binding: t; -*-
;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(defun my//modeline-set-box (&rest _)
  "Draw a mode-line box matching the current default background."
  (when (display-graphic-p)
    (let* ((border-width 4)
	   (default-bg (face-attribute 'default :background)))
      (set-face-attribute 'mode-line nil
			  :box `(:line-width ,border-width :color ,default-bg))
      (set-face-attribute 'mode-line-inactive nil
			  :box `(:line-width ,border-width :color ,default-bg)))))

(use-package doom-modeline
  :custom
  (doom-modeline-height 22)
  :config
  (doom-modeline-mode 1)
  ;; Applies immediately for a normal GUI launch; a no-op under a daemon
  ;; (no graphic frame yet).
  (my//modeline-set-box)
  ;; Keep the border in sync when the theme changes.
  (add-hook 'enable-theme-functions #'my//modeline-set-box)
  ;; Under a daemon the first real frame only exists once a client
  ;; connects; defer so doom-modeline finishes its own face setup first.
  (add-hook 'server-after-make-frame-hook
	    (lambda () (run-at-time 0 nil #'my//modeline-set-box))))
