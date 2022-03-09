(use-package hydra)

(defhydra my/hydra-create (:color blue :hint nil :pre (message "Create"))
  "
  _s_ New scratch
  "
  ("s" (my/create-scratch))
  ("q" nil))

(defhydra my/hydra-files (:color blue :hint nil :pre (message "Open"))
  "
  _c_ Emacs configuration
  _r_ Recent files
  "
  ("c" (find-file user-init-file))
  ("r" recentf-open-files)
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
  _c_ Create…        _x_ Expand region
  _o_ Open files…    _t_ Toggle…
  _g_ Git…           _F_ Flyspell…
  _S_ Straight…      _R_ Reload configuration
  "
  ("c" my/hydra-create/body)
  ("F" my/hydra-flyspell/body)
  ("g" my/hydra-git/body)
  ("o" my/hydra-files/body)
  ("R" (load-file user-init-file))
  ("S" my/hydra-straight/body)
  ("t" my/hydra-toggle/body)
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my/hydra/body)
(global-set-key (kbd "C-ö") 'my/hydra/body)
