(use-package embark
  :demand t
  :bind (:map embark-general-map ("C-." . embark-cycle))
  :config
  (setq embark-indicators '(embark-verbose-indicator embark-highlight-indicator embark-isearch-highlight-indicator)))

(use-package embark-consult
  :demand t)
