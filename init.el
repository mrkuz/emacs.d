(my//load-module "elpaca")

(use-package hydra)
(elpaca-wait)

;; -------------------------------------------------------------------------------------------------
;; Modules
;; -------------------------------------------------------------------------------------------------

(my//load-module "scratch")
(my//load-module "editing")
(my//load-module "ediff")
(my//load-module "help")

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-open (:color blue :hint nil)
  "
^Open^
-----------------------
_c_ Emacs configuration
"
  ("c" (find-file user-init-file))
  ("q" nil))


(defhydra my//hydra (:color blue :hint nil)
  "
^Files^       ^Miscellaneous^
---------------------------------------
_o_ Open…     _x_ Expand region
^ ^           _R_ Reload configuration
"
  ("o" my//hydra-open/body)
  ("R" (load-file user-init-file))
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my//hydra/body)
(global-set-key (kbd "C-ö") 'my//hydra/body)
