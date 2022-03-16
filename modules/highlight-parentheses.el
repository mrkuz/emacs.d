(use-package highlight-parentheses
  :init
  (setq highlight-parentheses-delay 0)
  ;; Highlight parens right before cursor
  (setq hl-paren-highlight-adjacent t)
  (global-highlight-parentheses-mode))
