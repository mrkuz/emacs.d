(use-package orderless
  :init
  (setq orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)
        completion-styles '(orderless)
        completion-category-defaults nil
        ;; Support for wildcards when opening files
        completion-category-overrides '((file (styles partial-completion)))))
