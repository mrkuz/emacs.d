(use-package ob
  :ensure nil
  :init
  ;; Don't auto-indent source
  (setq org-src-preserve-indentation t)
  ;; Don't ask for confirmation on evaluate
  (setq org-confirm-babel-evaluate nil)
  ;; Load language support
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (shell . t))))
