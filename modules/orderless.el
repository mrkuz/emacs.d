;; Use orderless-regexp when component ends with !
(defun my/regexp-only (pattern _index _total)
  (when (string-suffix-p "!" pattern)
    `(orderless-regexp . ,(substring pattern 0 -1))))

(use-package orderless
  :init
  (setq orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)
        orderless-style-dispatchers '(my/regexp-only)
        completion-styles '(orderless)
        completion-category-defaults nil
        ;; Support for wildcards when opening files
        completion-category-overrides '((file (styles partial-completion)))))
