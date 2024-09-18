(use-package hydra)
(elpaca-wait)

(defun my/zen-mode ()
  "Mode for distraction free editing"
  (interactive)
  (setq-local cursor-type 'bar)
  (setq mode-line-format "")
  (setq header-line-format "")
  (tab-bar-mode -1)
  (olivetti-mode))

(defun my/elpaca-update ()
  "Update Elpaca packages"
  (interactive)
  (elpaca-update-menus)
  (elpaca-update-all t)
  (elpaca-write-lockfile (expand-file-name "elpaca/packages.lock" user-emacs-directory)))

(defhydra my/hydra-create (:color blue :hint nil :pre (message "Create"))
  "
  _s_ Scratch buffer
  _t_ Terminal
  "
  ("s" crux-create-scratch-buffer)
  ("t" multi-vterm)
  ("q" nil))

(defhydra my/hydra-desktop (:color blue :hint nil :pre (message "Desktop"))
  "
  _s_ Save
  _r_ Restore
  "
  ("s" (desktop-save desktop-dirname))
  ("r" desktop-read)
  ("q" nil))

(defhydra my/hydra-edit (:color blue :hint nil :pre (message "Edit"))
  "
  _d_ Duplicate
  _f_ Format buffer
  "
  ("d" crux-duplicate-current-line-or-region)
  ("f" crux-cleanup-buffer-or-region)
  ("q" nil))

(defhydra my/hydra-goto (:color blue :hint nil :pre (message "Go to"))
  "
  _l_ Last change   _i_ Interactive menu
  _w_ Word
  "
  ("i" consult-imenu)
  ("l" goto-last-change)
  ("w" avy-goto-word-1)
  ("q" nil))

(defhydra my/hydra-insert (:color blue :hint nil :pre (message "Insert"))
  "
  _s_ Snippet
  "
  ("s" yas-insert-snippet)
  ("q" nil))

(defhydra my/hydra-open (:color blue :hint nil :pre (message "Open"))
  "
  _c_ Emacs configuration    _t_ todo.org    _a_ Agenda
  _r_ Recent file            _n_ Note
  _u_ Undo history           _j_ Journal
  "
  ("a" my/org-ql-agenda)
  ("c" (find-file user-init-file))
  ("j" my/open-journal-file)
  ("n" org-roam-node-find)
  ("r" consult-recent-file)
  ("t" my/org-find-todo)
  ("u" vundo)
  ("q" nil))

(defhydra my/hydra-help (:color blue :hint nil :pre (message "Help"))
  "
  _._ Describe at point
  _s_ Describe symbol
  "
  ("." helpful-at-point)
  ("s" helpful-symbol)
  ("q" nil))

(defhydra my/hydra-git (:color blue :hint nil :pre (message "Git"))
  "
  _f_ Act on file     _d_ Diff hunk
  _c_ Run command     _r_ Revert hunk     
  _s_ Show status
  "
  ("d" git-gutter:popup-hunk)
  ("f" magit-file-dispatch)
  ("c" magit-dispatch)
  ("r" git-gutter:revert-hunk)
  ("s" magit-status)
  ("q" nil))

(defhydra my/hydra-packages (:color blue :hint nil :pre (message "Packages"))
  "
  _u_ Update all       _m_ Manage packages
  _t_ Try
  "
  ("m" elpaca-manager)
  ("t" elpaca-try)
  ("u" my/elpaca-update)
  ("q" nil))

(defhydra my/hydra-toggle (:color blue :hint nil :pre (message "Toggle"))
  "
  _w_ Whitespace mode
  _v_ Visual line mode
  _z_ Zen mode
  "
  ("v" visual-line-mode)
  ("w" whitespace-mode)
  ("z" my/zen-mode)
  ("q" nil))

(defhydra my/hydra-spelling (:color blue :hint nil :pre (message "Spelling"))
  "
  _._ Correct at point
  _n_ Correct next
  _p_ Correct previous
  "
  ("." flyspell-correct-at-point)
  ("n" flyspell-correct-next)
  ("p" flyspell-correct-move)
  ("q" nil))

(defhydra my/hydra-tools (:color blue :hint nil :pre (message "Tools"))
  "
  _p_ Power Thesaurus
  "
  ("p" powerthesaurus-lookup-dwim)
  ("q" nil))

(defhydra my/hydra (:color blue :hint nil :pre (message "General commands"))
  "
  _c_ Create…   _e_ Edit…     _G_ Git…        _P_ Packages…   _x_ Expand region
  _o_ Open…     _i_ Insert…   _s_ Spelling…   _h_ Help…       _;_ Embark
  _g_ Go to…    _t_ Toggle…   _T_ Tools…      _D_ Desktop…    _R_ Reload configuration
  "
  (";" embark-act)
  ("c" my/hydra-create/body)
  ("D" my/hydra-desktop/body)
  ("e" my/hydra-edit/body)
  ("g" my/hydra-goto/body)
  ("G" my/hydra-git/body)
  ("h" my/hydra-help/body)
  ("i" my/hydra-insert/body)
  ("o" my/hydra-open/body)
  ("R" (load-file user-init-file))
  ("s" my/hydra-spelling/body)
  ("P" my/hydra-packages/body)
  ("t" my/hydra-toggle/body)
  ("T" my/hydra-tools/body)
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my/hydra/body)
(global-set-key (kbd "C-ö") 'my/hydra/body)

