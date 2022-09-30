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
(my/load-config "org") ;; depends on org-journal

(my/load-config "overrides")

;;--------------------------------------------------------------------------------------------------
;; Modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "my-symbol-at-point-overlay")
(my/load-module "my-markdown-preview")

(my/load-module "vertico")
(my/load-module "orderless")
(my/load-module "marginalia")
(my/load-module "consult")
(my/load-module "crux")
;; (my/load-module "embark")
(my/load-module "lacarte") ;; depends on marginalia
(my/load-module "hungry-delete")
(my/load-module "move-text")
(my/load-module "expand-region")
(my/load-module "goto-last-change")
(my/load-module "org-protocol")
(my/load-module "org-bullets")
(my/load-module "org-ql")
(my/load-module "org-journal")
(my/load-module "org-roam")
(my/load-module "my-search-notes")
(my/load-module "git-gutter")
(my/load-module "magit")
(my/load-module "multi-term")
(my/load-module "visual-fill-column")
(my/load-module "undo-tree")
(my/load-module "highlight-parentheses")
;; (my/load-module "highlight-symbol")
;; (my/load-module "which-key")
(my/load-module "dumb-jump")
(my/load-module "yafolding")
(my/load-module "helpful") ;; depends on yafolding
(my/load-module "company") ;; depends on helpful
(my/load-module "yasnippet")
(my/load-module "flyspell-correct")
(my/load-module "powerthesaurus")

(my/load-module "yaml-mode")
(my/load-module "dockerfile-mode")
(my/load-module "docker-compose-mode")
(my/load-module "markdown-mode")
(my/load-module "nix-mode")
(my/load-module "fish-mode")

(my/load-module "hydra")
