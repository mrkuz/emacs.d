(use-package hydra)

(defhydra my/hydra-create (:color blue :hint nil :pre (message "Create"))
  "
  _s_ Scratch buffer
  _n_ Note
  "
  ("n" org-roam-node-find)
  ("s" crux-create-scratch-buffer)
  ("q" nil))

(defhydra my/hydra-edit (:color blue :hint nil :pre (message "Edit"))
  "
  _d_ Duplicate
  _f_ Format buffer
  _x_ Expand region
  "
  ("d" crux-duplicate-current-line-or-region)
  ("f" crux-cleanup-buffer-or-region)
  ("x" er/expand-region)
  ("q" nil))

(defhydra my/hydra-open (:color blue :hint nil :pre (message "Open"))
  "
  _c_ Emacs configuration    _t_ todo.org    _a_ Agenda
  _r_ Recent file            _n_ Note        _u_ Undo tree

  "
  ("a" my/org-ql-agenda)
  ("c" (find-file user-init-file))
  ("n" org-roam-node-find)
  ("r" consult-recent-file)
  ("t" my/org-find-todo)
  ("u" undo-tree-visualize)
  ("q" nil))

(defhydra my/hydra-help (:color blue :hint nil :pre (message "Help"))
  "
  _._ Descripe at point
  _a_ Apropos
  "
  ("." helpful-at-point)
  ("a" consult-apropos)
  ("q" nil))

(defhydra my/hydra-git (:color blue :hint nil :pre (message "Git"))
  "
  _r_ Revert hunk
  "
  ("r" git-gutter:revert-hunk)
  ("q" nil))

(defhydra my/hydra-straight (:color blue :hint nil :pre (message "Straight"))
  "
  _p_ Pull all
  _f_ Freeze versions
  _u_ Use package
  "
  ("p" straight-pull-all)
  ("f" straight-freeze-versions)
  ("u" straight-use-package)
  ("q" nil))

(defhydra my/hydra-toggle (:color blue :hint nil :pre (message "Toggle"))
  "
  _v_ Visual line mode
  _w_ Whitespace mode
  "
  ("v" visual-line-mode)
  ("w" whitespace-mode)
  ("q" nil))

(defhydra my/hydra-flyspell (:color blue :hint nil :pre (message "Flyspell"))
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
  _c_ Create…    _t_ Toggle…          _g_ Git…         _h_ Help…
  _o_ Open…      _x_ Expand region    _F_ Flyspell…    _R_ Reload configuration
  _e_ Edit…      _a_ Agenda           _S_ Straight…
  "
  ("a" my/org-ql-agenda)
  ("c" my/hydra-create/body)
  ("e" my/hydra-edit/body)
  ("F" my/hydra-flyspell/body)
  ("g" my/hydra-git/body)
  ("h" my/hydra-help/body)
  ("o" my/hydra-open/body)
  ("R" (load-file user-init-file))
  ("S" my/hydra-straight/body)
  ("t" my/hydra-toggle/body)
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my/hydra/body)
(global-set-key (kbd "C-ö") 'my/hydra/body)
