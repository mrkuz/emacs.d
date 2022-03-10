;;--------------------------------------------------------------------------------------------------
;; Basic modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "straight")
(my/load-module "no-littering")
(my/load-module "diminish")

;;--------------------------------------------------------------------------------------------------
;; Configuration
;;--------------------------------------------------------------------------------------------------

(my/load-config "user")
(my/load-config "appearance")
(my/load-config "behavior")

;;--------------------------------------------------------------------------------------------------
;; Modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "my")
(my/load-module "vertico")
(my/load-module "orderless")
(my/load-module "marginalia")
(my/load-module "consult")
(my/load-module "embark")
(my/load-module "git-gutter")
(my/load-module "visual-fill-column")
(my/load-module "which-key")
(my/load-module "company")
(my/load-module "flyspell")
;; Configure minor behavior packages
(my/load-module "behavior")
;; Configure file modes
(my/load-module "modes")
(my/load-module "hydra")
