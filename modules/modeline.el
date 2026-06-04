;; -------------------------------------------------------------------------------------------------
;; Packages
;; -------------------------------------------------------------------------------------------------

(use-package doom-modeline
  :custom
  (doom-modeline-height 22)
  :config
  (doom-modeline-mode 1)
  (let* ((border-width 4)
	 (default-bg (face-attribute 'default :background)))
    (set-face-attribute 'mode-line nil
			:box `(:line-width ,border-width :color ,default-bg))
    (set-face-attribute 'mode-line-inactive nil
			:box `(:line-width ,border-width :color ,default-bg))))
