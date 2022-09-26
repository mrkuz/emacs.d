(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :init
  (setq highlight-parentheses-delay 0)
  ;; Highlight parens right before cursor
  (setq hl-paren-highlight-adjacent t)
  (global-highlight-parentheses-mode))
