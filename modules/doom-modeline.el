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
  ;; No-op under a daemon, no graphic frame yet
  (my//modeline-set-box)
  (add-hook 'enable-theme-functions #'my//modeline-set-box)
  ;; For client frames; deferred, so doom-modeline sets up its faces first
  (add-hook 'server-after-make-frame-hook
	    (lambda () (run-at-time 0 nil #'my//modeline-set-box))))
