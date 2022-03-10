(use-package consult
  :bind (([remap yank-pop] . consult-yank-pop)
         ([remap goto-line] . consult-goto-line)))

(use-package consult-project-extra)
