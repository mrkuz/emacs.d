;; .project marks directory as root of project
(defun my//project-find-root (dir)
  (let ((root (locate-dominating-file dir ".project")))
    (if root (cons 'transient root)
      (ignore-errors (project-try-vc dir)))))

(use-package project
  :elpaca nil
  :config
  (setq project-find-functions '(my//project-find-root)))
