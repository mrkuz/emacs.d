;; .project marks directory as root of project
(defun my/project-find-root (dir)
  (let ((root (locate-dominating-file dir ".project")))
    (if root (cons 'transient root) nil)))

(use-package project
  :straight (:type built-in)
  :config
  (add-to-list 'project-find-functions 'my/project-find-root))
