;;--------------------------------------------------------------------------------------------------
;; Basic modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "elpaca")
(elpaca-wait)
(my/load-module "no-littering")
(elpaca-wait)
(my/load-module "exec-path-from-shell")
(my/load-module "diminish")
(elpaca-wait)

;;--------------------------------------------------------------------------------------------------
;; Configuration
;;--------------------------------------------------------------------------------------------------

(my/load-config "user")
(my/load-config "startup")
(my/load-config "fonts")
(my/load-config "modeline")
(my/load-config "tab-bar")
(my/load-config "minibuffer")
(my/load-config "scrolling")
(my/load-config "whitespace")
(my/load-config "backups")
(my/load-config "calendar")
(my/load-config "isearch")
(my/load-config "electric")
(my/load-config "recentf")
(my/load-config "dabbrev")
(my/load-config "ibuffer")
(my/load-config "dired")
(my/load-config "treesit")
(my/load-config "eglot")
(my/load-config "misc")
(my/load-config "flyspell")
(my/load-config "ediff")
(my/load-config "projects")
(my/load-config "org")
(my/load-config "org-agenda")
(my/load-config "org-archive")
(my/load-config "org-babel")
(my/load-config "org-capture")
(my/load-config "org-indent")
(my/load-config "org-protocol")
(my/load-config "org-refile")

(my/load-config "overrides")

;; (my/load-config "undo")

;;--------------------------------------------------------------------------------------------------
;; Modules
;;--------------------------------------------------------------------------------------------------

(my/load-module "my-symbol-at-point-overlay")
(my/load-module "my-markdown-preview")

(my/load-module "vertico")
(my/load-module "orderless")
(my/load-module "marginalia")

(my/load-module "nerd-icons")
(my/load-module "monokai-pro-theme")
(my/load-module "pulsar")

(my/load-module "consult")
(my/load-module "embark")
(my/load-module "crux")

(my/load-module "hungry-delete")
(my/load-module "move-text")
(my/load-module "expand-region")
(my/load-module "undo-fu")

(my/load-module "goto-last-change")
(my/load-module "avy")
(my/load-module "ace-window")
(my/load-module "dumb-jump")

(my/load-module "helpful")
(my/load-module "which-key")

(my/load-module "highlight-parentheses")
(my/load-module "olivetti")
(my/load-module "golden-ratio")

(my/load-module "vundo")
(my/load-module "dired-sidebar")
(my/load-module "ibuffer-sidebar")

(my/load-module "corfu")
(my/load-module "cape")
(my/load-module "flyspell-correct")
(my/load-module "yasnippet")

(my/load-module "org-bullets")
(my/load-module "org-ql")
(my/load-module "org-journal")
(my/load-module "org-roam")
(my/load-module "org-appear")

(my/load-module "git-gutter")
;; (my/load-module "magit")

(my/load-module "age")
(my/load-module "multi-vterm")

(my/load-module "powerthesaurus")

(my/load-module "nix-ts-mode")
(my/load-module "markdown-mode")
(my/load-module "lua-mode")
(my/load-module "terraform-mode")

(elpaca-wait)
(my/load-module "hydra")

;; (my/load-module "backup-walker.el")
;; (my/load-module "benchmark-init")
;; (my/load-module "calfw")
;; (my/load-module "chatgpt-shell")
;; (my/load-module "company")
;; (my/load-module "devdocs")
;; (my/load-module "docker-compose-mode")
;; (my/load-module "dockerfile-mode")
;; (my/load-module "doom-modeline")
;; (my/load-module "fish-mode")
;; (my/load-module "god-mode")
;; (my/load-module "groovy-mode")
;; (my/load-module "hide-mode-line")
;; (my/load-module "highlight-symbol")
;; (my/load-module "lacarte")
;; (my/load-module "kotlin-mode")
;; (my/load-module "my-appt")
;; (my/load-module "nix-mode")
;; (my/load-module "org-alert")
;; (my/load-module "restclient")
;; (my/load-module "straight")
;; (my/load-module "treesit-auto")
;; (my/load-module "undo-tree")
;; (my/load-module "visual-fill-column")
;; (my/load-module "yaml-mode")
