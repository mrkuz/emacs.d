;; See: https://github.com/minad/consult
(use-package consult
  :bind (([remap goto-line] . consult-goto-line))
  :init
  (setq completion-in-region-function #'consult-completion-in-region)
  :config
  ;; Disable expensive automatic previews
  (consult-customize consult-bookmark consult-recent-file consult-xref
		     consult--source-bookmark consult--source-file-register
		     consult--source-recent-file consult--source-project-recent-file
             :preview-key "M-."))
