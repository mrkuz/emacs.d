(my//load-module "elpaca")

(use-package transient)
(use-package hydra)
(elpaca-wait)

;; -------------------------------------------------------------------------------------------------
;; Modules
;; -------------------------------------------------------------------------------------------------

(my//load-module "scratch")
(my//load-module "backups")
(my//load-module "editing")
(my//load-module "ediff")
(my//load-module "help")
(my//load-module "markdown")
(my//load-module "gptel")

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

(defhydra my//hydra-elpaca (:color blue :hint nil)
  "
^Packages^
-----------------------
_u_ Update all
_t_ Try
 "
  ("t" elpaca-try)
  ("u" my/elpaca-update)
  ("q" nil))

(defhydra my//hydra (:color blue :hint nil)
  "
^Files^       ^Tools^       ^Miscellaneous^
----------------------------------------------------
_o_ Open…     _g_ gptel     _x_ Expand region
^ ^           ^ ^           _P_ Packages
^ ^           ^ ^           _R_ Reload configuration
"
  ("g" my//hydra-gptel/body)
  ("o" my//hydra-open/body)
  ("P" my//hydra-elpaca/body)
  ("R" (load-file user-init-file))
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my//hydra/body)
(global-set-key (kbd "C-ö") 'my//hydra/body)
