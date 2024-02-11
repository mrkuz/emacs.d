;; Use orderless-regexp when component starts with #
(defun my//orderless-regexp-only-dispatcher (pattern _index _total)
  (when (string-prefix-p "#" pattern)
    `(orderless-regexp . ,(substring pattern 1))))

;; See: https://github.com/oantolin/orderless
(use-package orderless
  :init
  (setq orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)
        orderless-style-dispatchers '(my//orderless-regexp-only-dispatcher)
        completion-styles '(orderless basic)
        ;; completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))
