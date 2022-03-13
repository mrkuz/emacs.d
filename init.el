;;--------------------------------------------------------------------------------------------------
;; Basic modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "straight")
(my/load-module "no-littering")
(my/load-module "diminish")
(my/load-module "my")

;;--------------------------------------------------------------------------------------------------
;; Configuration
;;--------------------------------------------------------------------------------------------------

(my/load-config "user")
(my/load-config "startup")
(my/load-config "fonts")
(my/load-config "modeline")
(my/load-config "minibuffer")
(my/load-config "scrolling")
(my/load-config "undo")
(my/load-config "whitespace")
(my/load-config "backups")
(my/load-config "calendar")
(my/load-config "misc")
(my/load-config "recentf")
(my/load-config "projects")
(my/load-config "ibuffer")
(my/load-config "dired")
(my/load-config "ediff")
(my/load-config "flyspell")
(my/load-config "org")

;;--------------------------------------------------------------------------------------------------
;; Modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "vertico")
(my/load-module "orderless")
(my/load-module "marginalia")
(my/load-module "consult")
;; (my/load-module "embark")
(my/load-module "hungry-delete")
(my/load-module "move-text")
(my/load-module "expand-region")
(my/load-module "org-protocol")
(my/load-module "org-bullets")
(my/load-module "org-ql")
(my/load-module "org-roam")
(my/load-module "git-gutter")
(my/load-module "visual-fill-column")
;; (my/load-module "which-key")
(my/load-module "company")
(my/load-module "flyspell-correct")
(my/load-module "yaml-mode")
(my/load-module "dockerfile-mode")
(my/load-module "docker-compose-mode")
(my/load-module "nix-mode")
(my/load-module "hydra")
