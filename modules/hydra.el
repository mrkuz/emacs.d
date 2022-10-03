(use-package hydra)

(defhydra my/hydra-create (:color blue :hint nil :pre (message "Create"))
  "
  _s_ Scratch buffer   _j_ Journal entry
  _n_ Note
  _t_ Terminal
  "
  ("j" org-journal-new-entry)
  ("n" org-roam-capture)
  ("s" crux-create-scratch-buffer)
  ("t" multi-term)
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
  _d_ Duplicate        _f_ Format buffer
  _x_ Expand region
  _m_ Multiple cursors
  "
  ("d" crux-duplicate-current-line-or-region)
  ("f" crux-cleanup-buffer-or-region)
  ("m" mc/mark-next-like-this)
  ("x" er/expand-region)
  ("q" nil))

(defhydra my/hydra-goto (:color blue :hint nil :pre (message "Go to"))
  "
  _L_ Last change   _d_ Dictionary
  _w_ Word
  _l_ Link
  "
  ("d" powerthesaurus-lookup-dwim)
  ("l" ace-link)
  ("L" goto-last-change)
  ("w" avy-goto-word-1)
  ("q" nil))

(defhydra my/hydra-insert (:color blue :hint nil :pre (message "Insert"))
  "
  _n_ Link to note
  "
  ("n" org-roam-node-insert)
  ("q" nil))

(defhydra my/hydra-open (:color blue :hint nil :pre (message "Open"))
  "
  _c_ Emacs configuration    _t_ todo.org    _a_ Agenda
  _r_ Recent file            _n_ Note        _u_ Undo tree
                           _j_ Journal
  "
  ("a" my/org-ql-agenda)
  ("c" (find-file user-init-file))
  ("j" (org-journal-new-entry t))
  ("n" org-roam-node-find)
  ("r" consult-recent-file)
  ("t" my/org-find-todo)
  ("u" undo-tree-visualize)
  ("q" nil))

(defhydra my/hydra-help (:color blue :hint nil :pre (message "Help"))
  "
  _._ Describe at point
  _a_ Apropos
  "
  ("." helpful-at-point)
  ("a" consult-apropos)
  ("q" nil))

(defhydra my/hydra-git (:color blue :hint nil :pre (message "Git"))
  "
  _f_ Act on file         _s_ Show status
  _g_ Run Git command
  _r_ Revert hunk
  "
  ("f" magit-file-dispatch)
  ("g" magit-dispatch)
  ("r" git-gutter:revert-hunk)
  ("s" magit-status)
  ("q" nil))

(defhydra my/hydra-packages (:color blue :hint nil :pre (message "Packages"))
  "
  _u_ Update all
  _f_ Freeze versions
  _t_ Try
  "
  ("u" straight-pull-all)
  ("f" straight-freeze-versions)
  ("t" straight-use-package)
  ("q" nil))

(defhydra my/hydra-toggle (:color blue :hint nil :pre (message "Toggle"))
  "
  _v_ Visual line mode
  _w_ Whitespace mode
  "
  ("v" visual-line-mode)
  ("w" whitespace-mode)
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

(defhydra my/hydra (:color blue :hint nil :pre (message "General commands"))
  "
  _c_ Create…    _g_ Go to…           _G_ Git…         _h_ Help…
  _o_ Open…      _t_ Toggle…          _P_ Packages…    _D_ Desktop…
  _e_ Edit…      _x_ Expand region    _S_ Spelling…    _M_ Run menu command
  _i_ Insert…                                      _R_ Reload configuration
  "
  ("c" my/hydra-create/body)
  ("D" my/hydra-desktop/body)
  ("e" my/hydra-edit/body)
  ("g" my/hydra-goto/body)
  ("G" my/hydra-git/body)
  ("h" my/hydra-help/body)
  ("i" my/hydra-insert/body)
  ("M" my/lacarte)
  ("o" my/hydra-open/body)
  ("R" (load-file user-init-file))
  ("S" my/hydra-spelling/body)
  ("P" my/hydra-packages/body)
  ("t" my/hydra-toggle/body)
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my/hydra/body)
(global-set-key (kbd "C-ö") 'my/hydra/body)
