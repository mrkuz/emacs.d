;; -*- lexical-binding: t; -*-
(my//load-module "elpaca")

;; -------------------------------------------------------------------------------------------------
;; Modules
;; -------------------------------------------------------------------------------------------------

;; Dependencies
(my//load-module "compat")
(my//load-module "hydra")
(my//load-module "no-littering")
(elpaca-wait)

;; Appearance
(my//load-module "doom-themes")
(my//load-module "doom-modeline")
(my//load-module "modeline")
(my//load-module "diff-hl")
(my//load-module "scrolling")

;; Core
(my//load-module "session")
(my//load-module "autorevert")
(my//load-module "exec-path-from-shell")
(my//load-module "system")
(my//load-module "age")
(my//load-module "secrets")

;; Editing
(my//load-module "backups")
(my//load-module "expreg")
(my//load-module "ediff")
(my//load-module "undo")
(my//load-module "vundo")
(my//load-module "yasnippet")
(my//load-module "indentation")
(my//load-module "deletion")
(my//load-module "electric")
(my//load-module "completion")
(my//load-module "minibuffer")
(my//load-module "vertico")
(my//load-module "marginalia")

;; Help
(my//load-module "help")

;; Modes
(my//load-module "markdown-mode")

;; Org
(my//load-module "org")
(my//load-module "org-protocol")
(my//load-module "org-journal")
(my//load-module "org-archive")
(my//load-module "org-agenda")
(my//load-module "org-superstar")
(my//load-module "org-appear")

;; AI
(my//load-module "gptel")

;; Miscellaneous
(my//load-module "bookmark")
(my//load-module "calendar")
(my//load-module "isearch")
(my//load-module "dired")
(my//load-module "ibuffer")
(my//load-module "scratch")
(my//load-module "vc")

;; -------------------------------------------------------------------------------------------------
;; Keybindings
;; -------------------------------------------------------------------------------------------------

(defhydra my//hydra-open (:color blue :foreign-keys warn :hint nil)
  "
^Open^
-------------------------------------
_c_ Emacs configuration  _r_ Recent file
_t_ todo.org
_j_ Journal
"
  ("c" (find-file user-init-file))
  ("t" my/org-open-todo)
  ("j" my/org-open-journal)
  ("r" recentf-open)
  ("q" nil))

(defhydra my//hydra-toggle (:color blue :foreign-keys warn :hint nil)
  "
^Toggle^
-----------------------
_v_ Visual line
_w_ Whitespace
"
  ("v" visual-line-mode)
  ("w" whitespace-mode)
  ("q" nil))

(defhydra my//hydra-elpaca (:color blue :foreign-keys warn :hint nil)
  "
^Packages^
-----------------------
_u_ Update all
_t_ Try
 "
  ("t" elpaca-try)
  ("u" my/elpaca-update)
  ("q" nil))

(defhydra my//hydra (:color blue :foreign-keys warn :hint nil)
  "
^Files^       ^Tools^       ^Miscellaneous^
----------------------------------------------------
_o_ Open…     _g_ gptel     _x_ Expand region
^ ^           _j_ Journal   _T_ Toggle…
^ ^           _G_ Git       _P_ Packages
^ ^           ^ ^           _R_ Reload configuration
"
  ("g" my//hydra-gptel/body)
  ("G" my//hydra-git/body)
  ("j" my//hydra-journal/body)
  ("o" my//hydra-open/body)
  ("P" my//hydra-elpaca/body)
  ("R" (load-file user-init-file))
  ("T" my//hydra-toggle/body)
  ("x" expreg-expand nil :color red)
  ("q" nil))

(global-set-key (kbd "C-;") 'my//hydra/body)
(global-set-key (kbd "C-ö") 'my//hydra/body)
