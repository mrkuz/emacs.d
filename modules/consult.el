(use-package consult
  :bind (([remap yank-pop] . consult-yank-pop)
         ([remap goto-line] . consult-goto-line))
  :init
  (setq completion-in-region-function #'consult-completion-in-region)
  :config
  (consult-customize consult-ripgrep
                     consult-git-grep
                     consult-grep
                     consult--source-recent-file
                     consult--source-project-recent-file
                     consult-recent-file
                     my/search-notes
                     :preview-key "M-."))
