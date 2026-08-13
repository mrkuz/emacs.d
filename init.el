;; -*- lexical-binding: t; -*-
(my//load-module "elpaca")

;; -------------------------------------------------------------------------------------------------
;; Modules
;; -------------------------------------------------------------------------------------------------

;; Dependencies
(my//load-module "compat")
(my//load-module "transient")
(my//load-module "hydra")
(elpaca-wait)

;; Appearance
(my//load-module "doom-themes")
(my//load-module "doom-modeline")
(my//load-module "diff-hl")
(my//load-module "scrolling")

;; Core
(my//load-module "no-littering")
(my//load-module "exec-path-from-shell")
(my//load-module "system")
(my//load-module "age")
(my//load-module "secrets")

;; Editing
(my//load-module "backups")
(my//load-module "expand-region")
(my//load-module "crux")
(my//load-module "ediff")
(my//load-module "undo")
(my//load-module "vundo")
(my//load-module "yasnippet")

;; Help
(my//load-module "help")

;; Modes
(my//load-module "markdown-mode")

;; Org
(my//load-module "org")
(my//load-module "org-protocol")
(my//load-module "org-journal")
(my//load-module "org-superstar")

;; AI
(my//load-module "gptel")

;; Miscellaneous
(my//load-module "bookmark")
(my//load-module "scratch")

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-open (:color blue :hint nil)
  "
^Open^
-----------------------
_c_ Emacs configuration
_t_ todo.org
_j_ Journal
"
  ("c" (find-file user-init-file))
  ("t" my/org-open-todo)
  ("j" my/org-open-journal)
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
^ ^           _j_ Journal   _P_ Packages
^ ^           _G_ Git       _R_ Reload configuration
"
  ("g" my//hydra-gptel/body)
  ("G" my//hydra-git/body)
  ("j" my//hydra-journal/body)
  ("o" my//hydra-open/body)
  ("P" my//hydra-elpaca/body)
  ("R" (load-file user-init-file))
  ("x" er/expand-region)
  ("q" nil))

(global-set-key (kbd "C-;") 'my//hydra/body)
(global-set-key (kbd "C-ö") 'my//hydra/body)
