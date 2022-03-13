(defun my/org-find-todo ()
  "Open configuration file."
  (interactive)
  (find-file (concat org-directory "/todo.org")))

(use-package org
  :straight (:type built-in)
  :diminish org-indent-mode
  :init
  (setq org-directory "~/org")
  ;; Open files with two levels open
  (setq org-startup-folded 'show2levels)
  ;; Allow setting refile targets as local file variable
  (put 'org-refile-targets 'safe-local-variable (lambda (_) t))

  ;; Add tags immediate after the headline
  (setq org-tags-column 0)
  ;; Hide ephasis marker characters
  (setq org-hide-emphasis-markers t)
  ;; Never add blank lines before new entries
  (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

  ;; Indentation
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq org-indent-indentation-per-level 1)
  (diminish 'org-indent-mode)

  ;; Archive
  (setq org-archive-location "~/org/.archive.org::* File: %s")
  ;; Don't add header to archive file
  (setq org-archive-file-header-format nil)

  ;; TODO keywords
  (setq org-todo-keywords '(
                            (sequence "TODO(t!)" "NEXT(n!)" "SCHEDULED(s!)" "WAITING(w!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "EVENT(e!)" "|" "DONE(d!)" "CANCELED(c!)")
                            (sequence "PROJECT(p!)" "ON_HOLD(h!) | DONE(d!)" "CANCELED(c!)")))
  ;; Insert log notes into LOGBOOK
  (setq org-log-into-drawer t)

  ;; Don't ask for confirmation on evaluate
  (setq org-confirm-babel-evaluate nil)
  ;; Load language support
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((emacs-lisp . t)
                                 (shell . t)))

  ;; Agenda
  (setq org-agenda-files '("~/org/todo.org" "~/org/projects/" "~/org/calendar/" "~/org/journal/" "~/org/mobile/"))
  ;; Capture
  (setq org-capture-templates '(
                                ("b" "New backlog entry" entry (file+olp "todo.org" "Backlog")
                                 "* %?\nCREATED: %U" :prepend t)
                                ("w" "Capture web page" entry (file "capture.org")
                                 "* %?\nCREATED: %U\nTITLE: %:description%\nURL: %:link\n\n%i" :prepend t)
                                ("p" "Capture primary selection" entry (file "capture.org")
                                 "* %?\nCREATED: %U\n\n%(gui-get-primary-selection)" :prepend t)
                                ))
  :bind (("C-c l" . 'org-store-link)
         ("C-c a" . 'org-agenda)
         ("C-c c" . 'org-capture))
  :hook (org-mode . org-indent-mode))
