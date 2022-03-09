;; Basic modules
(my/load-module "straight")
(my/load-module "no-littering")
(my/load-module "diminish")

;; Configuration
(my/load-config "user")
(my/load-config "appearance")
(my/load-config "behavior")

;; Modules
(my/load-module "my")
(my/load-module "vertico")
(my/load-module "orderless")
(my/load-module "marginalia")
(my/load-module "git-gutter")
(my/load-module "visual-fill-column")
(my/load-module "behavior")
(my/load-module "modes")
(my/load-module "hydra")
(put 'dired-find-alternate-file 'disabled nil)
