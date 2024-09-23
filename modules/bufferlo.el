(defun my//find-file ()
  "Find file"
  (interactive)
  (call-interactively 'find-file)
  (let ((project (project-current)))
    (when project
      (let* ((project-name (project-name project))
             (project-tab (or (tab-bar--tab-index-by-name project-name) -1))
             (buffer (current-buffer)))
        (when (not (= project-tab (tab-bar--current-tab-index)))
          (bufferlo-remove buffer)
          (tab-bar-switch-to-tab project-name)
          (switch-to-buffer buffer))))))

(use-package bufferlo
  :demand t
  :bind (([remap switch-to-buffer] . bufferlo-find-buffer-switch)
         ("C-x F" . my//find-file)
         ("C-x B" . bufferlo-switch-to-buffer))
  :config
  (bufferlo-mode 1))
