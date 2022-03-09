(use-package hydra)

(defhydra my/hydra-create (:color blue :hint nil :pre (message "Create"))
  "
  _s_ New scratch
  "
  ("s" (my/create-scratch))
  ("q" nil))

(defhydra my/hydra-files (:color blue :hint nil :pre (message "Open files"))
  "
  _c_ Config
  "
  ("c" (find-file user-init-file))
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

(defhydra my/hydra (:color blue :hint nil :pre (message "General commands"))
  "
  _c_ Create…       
  _o_ Open files…       
  _S_ Straight…
  _R_ Reload configuration
  "
  ("c" my/hydra-create/body)
  ("o" my/hydra-files/body)
  ("R" (load-file user-init-file))
  ("S" my/hydra-straight/body)
  ("q" nil))

(global-set-key (kbd "C-;") 'my/hydra/body)
(global-set-key (kbd "C-ö") 'my/hydra/body)
